Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A1C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Nov 2022 15:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKOPqp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiKOPqV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Nov 2022 10:46:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA232DAAE;
        Tue, 15 Nov 2022 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668527180; x=1700063180;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Qq2XUXt8gbfZmC6g0R1Hfo9Sn+JsGPDJ3ywIC7Po7w=;
  b=g2blphrXMdrNGleAb6ZlVXZjXYRLfQ+SfegEMR9UugQTv5n+RghhWiyR
   4fZGxyuWfiLTbcWxkispY7m8BZqUX51jGJF17FBW0ENyC2qc6dGkj7ldU
   S64SwAsKwKDsVLfm06PgXwMT01jih0IEDubn42LtePAdrPVio7ir64PLh
   8ov8bKzebyvLcLdJDAD9CHB4Vx80GNyNIJ8VkU3zXss9VunDtWpnljMoj
   L1Z+D8oDUCUXsDrjSnasgre6o6b6MpVZbe8Lq7D/b6NCNlWzJAU7/Q+n3
   Dk7ZQPoruJjSE0j6VuCsMfgvxEZc0GRJHTMzHdZagVsnxPAIkab8a6p0z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295648296"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="295648296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:46:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672034156"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="672034156"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:46:15 -0800
Date:   Tue, 15 Nov 2022 17:46:13 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 09/14] serial: liteuart: fix rx loop variable types
In-Reply-To: <20221112212125.448824-10-gsomlo@gmail.com>
Message-ID: <eb41beea-dc4c-fd3c-7ecc-1f49fe5b288c@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-10-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-173275834-1668527179=:2268"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-173275834-1668527179=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Update variable types to match the signature of uart_insert_char()
> which consumes them.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index e9e99d6b5fef..974da0f73257 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -72,8 +72,7 @@ static void liteuart_timer(struct timer_list *t)
>  	struct liteuart_port *uart = from_timer(uart, t, timer);
>  	struct uart_port *port = &uart->port;
>  	unsigned char __iomem *membase = port->membase;
> -	int ch;
> -	unsigned long status;
> +	unsigned int status, ch;
>  
>  	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
>  		ch = litex_read8(membase + OFF_RXTX);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-173275834-1668527179=:2268--
