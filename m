From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
Date: Fri, 10 Apr 2015 09:24:11 -0400
Message-ID: <5527CEFB.5070406@hurleysoftware.com>
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428671585-13310-1-git-send-email-frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 04/10/2015 09:13 AM, Frederic Danis wrote:
> This is needed by Bluetooth hci_uart module to be able to change speed
> of Bluetooth controller and local UART.

Because this is the lesser evil right now,

Reviewed-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
