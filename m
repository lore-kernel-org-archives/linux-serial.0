From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH RFC] tty_ldisc: add more limits to the @write_wakeup
Date: Wed, 11 Dec 2013 14:44:12 +0800
Message-ID: <52A809BC.2040909@freescale.com>
References: <1384327803-5925-1-git-send-email-b32955@freescale.com> <52A1A84B.80409@freescale.com> <52A1F8BF.5030204@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52A1F8BF.5030204-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8807=E6=97=A5 00:18, Peter Hurley =E5=86=
=99=E9=81=93:
> hci_uart_tx_wakeup() should perform the actual tx in a work item.=20
Does the "work item" mean a workqueue or a tasklet?
This patch is used to tell the line discipline writers to send the data=
=20
in the workqueue or a tasklet.

thanks
Huang Shijie
