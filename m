From: Breno Leitao <brenohl@br.ibm.com>
Subject: Re: [PATCH] jsm: Fixed EEH recovery error
Date: Mon, 12 Sep 2011 12:31:24 -0300
Message-ID: <4E6E25CC.5020101@br.ibm.com>
References: <1315834565-9280-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:48126 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132Ab1ILPbq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Sep 2011 11:31:46 -0400
Received: from /spool/local
	by br.ibm.com with XMail ESMTP
	for <linux-serial@vger.kernel.org> from <brenohl@br.ibm.com>;
	Mon, 12 Sep 2011 12:31:34 -0300
In-Reply-To: <1315834565-9280-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Cc: Thadeu Lima De Souza Cascardo <cascardo@linux.vnet.ibm.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/12/2011 10:36 AM, Lucas Kannebley Tavares wrote:
> There was an error on the jsm driver that would cause it to be unable to
> recover after a second error is detected.
>
> At the first error, the device recovers properly:
>
> [72521.485691] EEH: Detected PCI bus error on device 0003:02:00.0
> [72521.485695] EEH: This PCI device has failed 1 times in the last hour:
> ...
> [72532.035693] ttyn3 at MMIO 0x0 (irq = 49) is a jsm
> [72532.105689] jsm: Port 3 added
>
> However, at the second error, it cascades until EEH disables the device:
>
> [72631.229549] Call Trace:
> ...
> [72641.725687] jsm: Port 3 added
> [72641.725695] EEH: Detected PCI bus error on device 0003:02:00.0
> [72641.725698] EEH: This PCI device has failed 3 times in the last hour:
>
> It was caused because the PCI state was not being saved after the first
> restore. Therefore, at the second recovery the PCI state would not be
> restored.
>
> Signed-off-by: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <brenohl@br.ibm.com>

