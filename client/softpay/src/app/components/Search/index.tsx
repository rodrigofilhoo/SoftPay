'use client'
import React from "react"
import Link from "next/link"

function Search() {
    return (
        <Link href={""}>
            <label
                className="mx-auto mt-40 relative bg-white min-w-sm max-w-2xl flex flex-col md:flex-row items-center justify-center border py-2 px-2 rounded-2xl gap-2 shadow-2xl focus-within:border-gray-300"
                htmlFor="search-bar">
                <svg
                    className="w-4 h-4 ml-2 text-gray-500 dark:text-gray-400"
                    aria-hidden="true"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 20 20">
                    <path
                        stroke="currentColor"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                </svg>
                <input
                    id="search-bar"
                    placeholder="Busque o que quiser..."
                    className="px-6 py-2 w-full rounded-md flex-1 outline-none bg-white"
                />

                <button
                    className="w-full md:w-auto px-6 py-3 bg-purple-700 border-purple-700 text-white fill-white active:scale-95 duration-100 border will-change-transform overflow-hidden relative rounded-xl transition-all disabled:opacity-90"
                >

                    <div className="relative">
                        <div
                            className="flex items-center justify-center h-3 w-3 absolute inset-1/2 -translate-x-1/2 -translate-y-1/2 transition-all">
                            <svg
                                className="opacity-0 animate-spin w-full h-full" xmlns="http://www.w3.org/2000/svg" fill="none"
                                viewBox="0 0 24 24">
                                <circle
                                    className="opacity-25" cx="12" cy="12" r="10"
                                    stroke="currentColor"
                                    stroke-width="4">
                                </circle>
                                <path
                                    className="opacity-75"
                                    fill="currentColor"
                                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                </path>
                            </svg>
                        </div>

                        <div
                            className="flex items-center transition-all opacity-1 valid:"
                        >
                            <span
                                className="text-sm font-semibold whitespace-nowrap truncate mx-auto">
                                Buscar
                            </span>
                        </div>

                    </div>

                </button>
            </label>
        </Link>
    )
}

export default Search