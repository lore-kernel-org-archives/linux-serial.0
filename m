Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46DC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 10:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjJaKPz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Oct 2023 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjJaKPy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 06:15:54 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B10A1
        for <linux-serial@vger.kernel.org>; Tue, 31 Oct 2023 03:15:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 704B6E0011;
        Tue, 31 Oct 2023 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698747348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlapY09yIWGor+GfD4FtWichPuxFnnu9Iw6HSlf15sA=;
        b=fiuiPccJ5fbEqj7PpaT7rep5GEIZxXtAh5tu0MGL2iYCMQoCp/wRZBv++5jSwOHUmfwj9U
        ZwCqhpiShOqagdsnbJaAd85KnuVuuuL27Osh+2QeAGFuyQgwFPLeY0m4+vvQiaIOHGiS5+
        gKAIDqONHTL+4h19Knu/9ZBPFsqc8dhRlu3Q/VfsSyHgYbx1bn++060/MT8A3tAhj+3Jqe
        GK68ScEPwq8JvL+YjNgSZXOBlwZXGg9Z7QOlpGwIiSzErVQ5bqXLZfxO/pf3tPtdhwQoWH
        7UfSeeeN5Uu5Wi/GeQf9hMJCphePz6gXi3LaTf2NdlFVAxT2XJusJ4+umo6EmA==
Message-ID: <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
Date:   Tue, 31 Oct 2023 11:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com> <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com> <20231025064131.GZ27774@atomide.com>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231025064131.GZ27774@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/25/23 08:41, Tony Lindgren wrote:
> * Kevin Hilman <khilman@kernel.org> [231024 18:36]:
>> Tony Lindgren <tony@atomide.com> writes:
>>
>>> * Kevin Hilman <khilman@kernel.org> [231023 21:31]:
>>>> Instead, what should be happening is that when `no_console_suspend` is
>>>> set, there should be an extra pm_runtime_get() which increases the
>>>> device usecount such that the device never runtime suspends, and thus
>>>> the domain will not get powered off.
>>>
>>> We already have the runtime PM usage count kept in the driver (unless
>>> there's a bug somewhere). The issue is that on suspend the power domain
>>> still gets shut down.
>>>
>>> I suspect that some of the SoC power domains get
>>> force shut down on suspend somewhere?
>>
>> If setting GENPD_FLAG_ALWAYS_ON works as this patch proposes, then a
>> force shutdown would override that genpd flag also, so I suspect the 
>> runtime PM usage count is not correct.
> 
> OK good point.
> 
>> I quick skim of 8250_omap.c, and I don't see any pm_runtime_get() calls
>> that are conditional on no_console_suspend, which is what I would
>> suspect for the domain to stay on.
> 
> If a serial console is attached, we now have runtime PM usage count
> always kept. Users can detach the console via sysfs as needed. See these
> two earlier commits from Andy:
> 
> a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
> 
> Sounds like there's a bug somewhere. It's worth verifying if the runtime
> PM usage count is kept for 8250_omap on suspend.
> 
> Thomas, care to check your test case with the attached debug hack
> and by adding a call for pm_runtime_get_usage_count() on the suspend
> path?

Hi Tony,

Please find below the logs of the test you asked me.
I added the call of pm_runtime_get_usage_count at the end of the suspend
function.
The console is attached on 2800000.serial, it has usage_count=4.
Other serial has usage_count=3.

[    4.859058] port 2830000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2830000.serial:0
[    4.869478] port 2830000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 0 usecs
[    4.878602] omap8250 2830000.serial: PM: calling
omap8250_suspend+0x0/0x144 @ 114, parent: bus@100000
[    4.887813] omap8250 2830000.serial: omap8250_suspend: 1634:
usage_count = 3
[    4.894851] omap8250 2830000.serial: PM: omap8250_suspend+0x0/0x144
returned 0 after 7042 usecs
[    4.903538] port 2810000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2810000.serial:0
[    4.913957] port 2810000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 0 usecs
[    4.923080] omap8250 2810000.serial: PM: calling
omap8250_suspend+0x0/0x144 @ 114, parent: bus@100000
[    4.932288] omap8250 2810000.serial: omap8250_suspend: 1634:
usage_count = 3
[    4.939323] omap8250 2810000.serial: PM: omap8250_suspend+0x0/0x144
returned 0 after 7038 usecs
[    4.948010] port 2800000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2800000.serial:0
[    4.958433] port 2800000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 1 usecs
[    4.967557] omap8250 2800000.serial: PM: calling
omap8250_suspend+0x0/0x144 @ 114, parent: bus@100000
[    4.976764] omap8250 2800000.serial: omap8250_suspend: 1634:
usage_count = 4
[    4.983799] omap8250 2800000.serial: PM: omap8250_suspend+0x0/0x144
returned 0 after 7036 usecs
[    4.992488] port 40a00000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 40a00000.serial:0
[    5.003081] port 40a00000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 0 usecs
[    5.012291] omap8250 40a00000.serial: PM: calling
omap8250_suspend+0x0/0x144 @ 114, parent: bus@100000:bus@28380000
[    5.022714] omap8250 40a00000.serial: omap8250_suspend: 1634:
usage_count = 3
[    5.029836] omap8250 40a00000.serial: PM: omap8250_suspend+0x0/0x144
returned 0 after 7124 usecs

Regards,

Thomas

8< -------------------------------
diff --git a/drivers/tty/serial/8250/8250_omap.c
b/drivers/tty/serial/8250/8250_omap.c
index ca972fd37725..b978f12fd542 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1631,6 +1631,9 @@ static int omap8250_suspend(struct device *dev)
                err = pm_runtime_force_suspend(dev);
        flush_work(&priv->qos_work);

+       dev_info(dev, "%s: %d: usage_count = %d\n",
+                __func__, __LINE__, pm_runtime_get_usage_count(dev));
+
        return err;
 }


> 
> Regards,
> 
> Tony
> 
> 8< -------------------------------
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -129,6 +129,11 @@ static inline void pm_runtime_get_noresume(struct device *dev)
>  	atomic_inc(&dev->power.usage_count);
>  }
>  
> +static inline int pm_runtime_get_usage_count(struct device *dev)
> +{
> +	return atomic_read(&dev->power.usage_count);
> +}
> +
>  /**
>   * pm_runtime_put_noidle - Drop runtime PM usage counter of a device.
>   * @dev: Target device.


