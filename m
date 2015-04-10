From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [Patch] tty: Re-add external interface for tty_set_termios()
Date: Fri, 10 Apr 2015 08:13:49 -0400
Message-ID: <5527BE7D.4040303@hurleysoftware.com>
References: <1428055395-10648-1-git-send-email-frederic.danis@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428055395-10648-1-git-send-email-frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 04/03/2015 06:03 AM, Frederic Danis wrote:
> This is a partial revert of patch "tty: Remove external interface for
> tty_set_termios()" from Peter Hurley (2015-01-25 SHA1 632f32e2107) to
> set tty_set_termios() publicly available.
> 
> This will be needed by Bluetooth hci_uart module to be able to change
> Bluetooth controller and local UART speed during vendor specific
> initialization.

Please resend to tty maintainers (and cc me).
