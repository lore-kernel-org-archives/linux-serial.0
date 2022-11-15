Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D743C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 15 Nov 2022 15:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiKOPky (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiKOPkp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Nov 2022 10:40:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D82C67F;
        Tue, 15 Nov 2022 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526844; x=1700062844;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FpnPDUGrGucgSZy+tetU42+AdyNRLuB7iB02PDjuj+M=;
  b=DFHsYW+LSYMZnX2grrnHzIUW6iVx6arvrv3LkWshESS78cT/LQL76Mh+
   Udy4d1qni9yN8zZk0o0MYNC+yrhGyVhvzUqd3Q+rjx6RQmacQHfRfoPcB
   FwYYqTMsnbqV+sDOq9vguU+7lyVkqUKvh2I5zmMiI8qcKYCy30mJZajSc
   iPM5mgcAj6OynoUqruRN3wKlEPQjgage1Tnwe9PSx6uiD3S8vXray5Rsy
   GCDWPikLt7EwJY4pL5OiAARPy0ICSnMV4ryyov+2ml6lvChKvhrVa1e1M
   d7ehc/CyRX2igHYv8pS0/Tg/N/z7sDzEzyN8OOmCwWUu8JJjZ0UnIjqEk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="339081810"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339081810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:40:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727991324"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="727991324"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:40:41 -0800
Date:   Tue, 15 Nov 2022 17:40:39 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 05/14] serial: liteuart: minor style fix in
 liteuart_init()
In-Reply-To: <20221112212125.448824-6-gsomlo@gmail.com>
Message-ID: <9b55b481-a8bc-f5a5-d779-fb1e652c7fa5@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-6-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-658060953-1668526844=:2268"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-658060953-1668526844=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 5b684fd198b7..047d5ad32e13 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -398,12 +398,10 @@ static int __init liteuart_init(void)
>  		return res;
>  
>  	res = platform_driver_register(&liteuart_platform_driver);
> -	if (res) {
> +	if (res)
>  		uart_unregister_driver(&liteuart_driver);
> -		return res;
> -	}
>  
> -	return 0;
> +	return res;
>  }
>  
>  static void __exit liteuart_exit(void)

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-658060953-1668526844=:2268--
