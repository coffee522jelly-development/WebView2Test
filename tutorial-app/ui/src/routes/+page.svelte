<script lang="ts">
	import { onMount } from 'svelte';
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import * as RadioGroup from '$lib/components/ui/radio-group';
	import * as Select from '$lib/components/ui/select';
	import * as Table from '$lib/components/ui/table';

	// State for MFC-like controls
	let editValue = $state('Initial Text');
	let radioValue = $state('option-one');
	let selectValue = $state('apple');
	let items = $state([
		{ id: 1, name: 'Item 1', status: 'Active' },
		{ id: 2, name: 'Item 2', status: 'Pending' },
		{ id: 3, name: 'Item 3', status: 'Inactive' }
	]);

	const selectOptions = [
		{ value: 'apple', label: 'Apple' },
		{ value: 'banana', label: 'Banana' },
		{ value: 'cherry', label: 'Cherry' }
	];

	// WebView2 Bridge Logic
	function sendToNative(action: string, data: any) {
		if (window.chrome && window.chrome.webview) {
			window.chrome.webview.postMessage({ action, data });
		} else {
			console.log('Native bridge not available. Action:', action, 'Data:', data);
		}
	}

	onMount(() => {
		if (window.chrome && window.chrome.webview) {
			window.chrome.webview.addEventListener('message', (event: any) => {
				const { action, data } = event.data;
				if (action === 'updateItems') {
					items = data;
				}
			});
		}
	});

	// MFC Feature Implementations
	function copyToClipboard() {
		const text = `Edit: ${editValue}, Radio: ${radioValue}, Select: ${selectValue}`;
		navigator.clipboard.writeText(text);
		sendToNative('clipboardCopy', text);
	}

	function handleDrop(event: DragEvent) {
		event.preventDefault();
		const data = event.dataTransfer?.getData('text/plain');
		if (data) {
			editValue = data;
			sendToNative('dropReceived', data);
		}
	}

	function handleDragOver(event: DragEvent) {
		event.preventDefault();
	}
</script>

<div class="container mx-auto p-4 space-y-6" ondragover={handleDragOver} ondrop={handleDrop}>
	<h1 class="text-3xl font-bold mb-6">MFC-like UI Tutorial (SvelteKit + WebView2)</h1>

	<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
		<!-- Edit Control & Text -->
		<Card.Root>
			<Card.Header>
				<Card.Title>Edit Control & Static Text</Card.Title>
			</Card.Header>
			<Card.Content class="space-y-4">
				<div class="space-y-2">
					<Label for="edit-control">Static Text (Label) / Edit Control</Label>
					<Input id="edit-control" bind:value={editValue} placeholder="Enter some text..." />
				</div>
				<p class="text-sm text-muted-foreground">Current Value: {editValue}</p>
			</Card.Content>
		</Card.Root>

		<!-- Radio Buttons -->
		<Card.Root>
			<Card.Header>
				<Card.Title>Radio Button Control</Card.Title>
			</Card.Header>
			<Card.Content>
				<RadioGroup.Root bind:value={radioValue}>
					<div class="flex items-center space-x-2">
						<RadioGroup.Item value="option-one" id="r1" />
						<Label for="r1">Option One</Label>
					</div>
					<div class="flex items-center space-x-2">
						<RadioGroup.Item value="option-two" id="r2" />
						<Label for="r2">Option Two</Label>
					</div>
				</RadioGroup.Root>
			</Card.Content>
		</Card.Root>

		<!-- Combo Box (Select) -->
		<Card.Root>
			<Card.Header>
				<Card.Title>Combo Box (Select)</Card.Title>
			</Card.Header>
			<Card.Content>
				<Select.Root type="single" bind:value={selectValue}>
					<Select.Trigger class="w-[180px]">
						{selectOptions.find((o) => o.value === selectValue)?.label ?? 'Select a fruit'}
					</Select.Trigger>
					<Select.Content>
						{#each selectOptions as option}
							<Select.Item value={option.value}>{option.label}</Select.Item>
						{/each}
					</Select.Content>
				</Select.Root>
			</Card.Content>
		</Card.Root>

		<!-- Clipboard & Actions -->
		<Card.Root>
			<Card.Header>
				<Card.Title>Actions (Clipboard & Bridge)</Card.Title>
			</Card.Header>
			<Card.Content class="space-y-4">
				<Button onclick={copyToClipboard}>Copy Current State to Clipboard</Button>
				<p class="text-xs text-muted-foreground">Try dropping text onto this window to update the Edit control.</p>
			</Card.Content>
		</Card.Root>
	</div>

	<!-- List Control (Table) -->
	<Card.Root>
		<Card.Header>
			<Card.Title>List Control (Table)</Card.Title>
		</Card.Header>
		<Card.Content>
			<Table.Root>
				<Table.Header>
					<Table.Row>
						<Table.Head>ID</Table.Head>
						<Table.Head>Name</Table.Head>
						<Table.Head>Status</Table.Head>
					</Table.Row>
				</Table.Header>
				<Table.Body>
					{#each items as item}
						<Table.Row>
							<Table.Cell>{item.id}</Table.Cell>
							<Table.Cell>{item.name}</Table.Cell>
							<Table.Cell>{item.status}</Table.Cell>
						</Table.Row>
					{/each}
				</Table.Body>
			</Table.Root>
		</Card.Content>
	</Card.Root>
</div>

<style>
	:global(body) {
		background-color: hsl(var(--background));
		color: hsl(var(--foreground));
	}
</style>
