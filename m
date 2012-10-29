From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] n_gsm: prevent crash due to dereferencing NULL gsm->tty
Date: Mon, 29 Oct 2012 16:29:47 +0000
Message-ID: <20121029162947.6270b4da@pyramind.ukuu.org.uk>
References: <26026_1351239109_508A45C4_26026_63_1_508A45C1.3010407@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26026_1351239109_508A45C4_26026_63_1_508A45C1.3010407@sagemcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillaume Juan <guillaume.juan@sagemcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 26 Oct 2012 10:11:45 +0200
Guillaume Juan <guillaume.juan@sagemcom.com> wrote:

> From: Guillaume Juan <guillaume.juan@sagemcom.com>
> 
> If gsm->tty happens to be NULL in gsmld_output, avoid crashing the kernel (the crash is replaced by a warning dump).

More important is fixing the bug completely. I agree there is a bug I
don't think your fix is sufficient however.


You no longer set dlci->dead before doing the dlci release so what stops
a SABM from the other end racing this ?

Also moving the gsm_dlci_release seems to have no value at all because
there is no locking in the code concerned so viewed from any other thread
you've changed nothing but timings. Yes its probably way harder to hit.

I can see two ways of tackling it both of which basically come down to
the same thing. In gsmld_detach_gsm after the gsm_cleanup_mux we need to

- be sure the thing cannot re-open
- wait until all the DLCIs are dead

then do the tty_kref_put and gsm->tty = NULL

Thoughts ?

Alan
