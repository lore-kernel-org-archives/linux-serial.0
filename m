From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH RFC] tty_ldisc: add more limits to the @write_wakeup
Date: Wed, 11 Dec 2013 06:47:11 -0500
Message-ID: <52A850BF.1000408@hurleysoftware.com>
References: <1384327803-5925-1-git-send-email-b32955@freescale.com> <52A1A84B.80409@freescale.com> <52A1F8BF.5030204@hurleysoftware.com> <52A809BC.2040909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:34822 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406Ab3LKLrO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 06:47:14 -0500
In-Reply-To: <52A809BC.2040909@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, marcel@holtmann.org, linux-bluetooth@vger.kernel.org

On 12/11/2013 01:44 AM, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8807=E6=97=A5 00:18, Peter Hurley =E5=
=86=99=E9=81=93:
>> hci_uart_tx_wakeup() should perform the actual tx in a work item.
> Does the "work item" mean a workqueue or a tasklet?
> This patch is used to tell the line discipline writers to send the da=
ta in the workqueue or a tasklet.

Yes, "work item" means struct work_struct.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
