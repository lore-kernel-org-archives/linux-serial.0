From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [parisc-linux] 2.6.15-rc1 freeing a reserved page from uart_shutdown
Date: Sun, 13 Nov 2005 07:06:24 -0700
Message-ID: <20051113140624.GM1658@parisc-linux.org>
References: <20051112063914.GH1658@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932507AbVKMOGZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051112063914.GH1658@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, parisc-linux@parisc-linux.org
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 11, 2005 at 11:39:14PM -0700, Matthew Wilcox wrote:
> I'm having some trouble with 2.6.15-rc1:
> 
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 640k freed
> Bad page state at free_hot_cold_page (in process 'init', page 108a24a0)
> flags:0x00000400 mapping:00000000 mapcount:0 count:0

False alarm.  I did a make clean and then rebuilt and the resulting kernel
booted fine.  Not sure what went wrong, but now it's unreproducible.
