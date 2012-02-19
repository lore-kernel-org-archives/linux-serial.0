From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: remove some orphan function declarations.
Date: Sun, 19 Feb 2012 20:09:00 +0400
Message-ID: <4F411E9C.7080108@ru.mvista.com>
References: <20120219022841.8254.86264.stgit@notabene.brown> <20120219022931.8254.29652.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:49687 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754268Ab2BSQKV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Feb 2012 11:10:21 -0500
In-Reply-To: <20120219022931.8254.29652.stgit@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 19-02-2012 6:29, NeilBrown wrote:

> commit 2fd149645eb

    Please also specify that commit's summary in parens.

> removed omap_uart_can_sleep and omap3_can_sleep,
> but not their declarations.  So remove those now.

> Signed-off-by: NeilBrown <neilb@suse.de>

WBR, Sergei
