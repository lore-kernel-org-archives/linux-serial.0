From: Borislav Petkov <bp@alien8.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000001e0
Date: Mon, 24 Oct 2016 20:56:59 +0200
Message-ID: <20161024185659.uwdkz23sic65eroc@pd.tnic>
References: <20161024144831.a4ieul22jck4vwk3@pd.tnic>
 <49489eb2-c7f5-369b-4552-d888cbc27719@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49489eb2-c7f5-369b-4552-d888cbc27719@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Michael Galbraith <mgalbraith@suse.de>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 24, 2016 at 05:28:24PM +0200, Jiri Slaby wrote:
> From the quick look, uart_write_wakeup should now be using refcounting.
> Does this help (compile-tested only)?

Yes, it does. Thanks!

Reported-and-tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
