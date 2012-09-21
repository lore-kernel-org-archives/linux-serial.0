From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
Date: Fri, 21 Sep 2012 16:05:39 -0700
Message-ID: <20120921230539.GE4918@kroah.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34632 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab2IVAKh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 20:10:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3650852pbb.19
        for <linux-serial@vger.kernel.org>; Fri, 21 Sep 2012 17:10:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Felipe Balbi <balbi@ti.com>

On Fri, Sep 21, 2012 at 10:36:27AM +0100, Russell King wrote:
> Move the PXA2xx/IXP4xx UDC header file into linux/platform_data as it
> only contains a driver platform data structure.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
