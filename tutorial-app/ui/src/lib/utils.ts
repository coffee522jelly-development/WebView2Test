import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import type { HTMLAttributes } from "svelte/elements";

export function cn(...inputs: ClassValue[]) {
	return twMerge(clsx(inputs));
}

export type WithElementRef<T extends HTMLAttributes<any>> = T & {
	ref?: any;
};

export type WithoutChildrenOrChild<T> = Omit<T, "children" | "child">;
export type WithoutChild<T> = Omit<T, "child">;
