From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH] serial: 8250_core: use pre-decrement for iteration limit
Date: Tue, 14 Oct 2014 13:52:34 +0200
Message-ID: <20141014115234.GB15616@ci00147.xsens-tech.local>
References: <1413212951-20901-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413212951-20901-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 13, 2014 at 05:09:11PM +0200, Frans Klaver wrote:
> In serial8250_rx_chars(), max_count is set to 256. Due to the
> post-decrement operator used in the while() condition, the maximum
> number of iterations actually 257. This is not a problem, but it is
> mildly surprising if you're debugging. Use pre-decrement instead.

I'm somewhat inclined to changing the title to something like:

serial: 8250_core: actually limit char reads to max_count

Frans
