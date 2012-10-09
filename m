From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [tty:tty-next 9/39] drivers/staging/dgrp/dgrp_tty.c:3177
 dgrp_tty_init() error: potential null dereference 'nd->nd_serial_ttdriver'.
Date: Tue, 9 Oct 2012 19:42:22 +0100
Message-ID: <20121009194222.64286dae@pyramind.ukuu.org.uk>
References: <20121007123549.GA24374@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33011 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab2JISho (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Oct 2012 14:37:44 -0400
In-Reply-To: <20121007123549.GA24374@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Bill Pemberton <wfp5p@virginia.edu>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

I think thats the tip of the iceberg at best 8)

Alan
