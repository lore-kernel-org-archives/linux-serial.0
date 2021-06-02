Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9DC47083
	for <linux-serial@archiver.kernel.org>; Wed,  2 Jun 2021 13:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019DE613D6
	for <linux-serial@archiver.kernel.org>; Wed,  2 Jun 2021 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFBNiq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:38:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFBNip (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Jun 2021 09:38:45 -0400
Received: from [192.168.1.155] ([95.114.42.59]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fDl-1lohtv2ncd-004F0P; Wed, 02 Jun 2021 15:36:56 +0200
Subject: Re: [PATCH] serial:Add SUNIX SDC serial port driver
To:     Moriis Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com
References: <20210528092307.5950-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <8bd83677-17dc-b13b-b991-8a60a2b8ef6c@metux.net>
Date:   Wed, 2 Jun 2021 15:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210528092307.5950-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XPpFSmarDrs0P7crA5G/MZvg4HqyruM/LUO/O2XODVjOBq517Lr
 dKUJck16AxVPqAF2IL/3sjDOU7XnMDaUWrNl279ekRFXW28XCugbB7p4TOeJqceyVOzEE8i
 4IRUYtSHB1toRiN1OS4DpsFJvuVAF2yDvM2C48wD5F1aHo6GveDdyL/CO2HUNSIjHSk856E
 IspTq/lXg+yfYeCBcts1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JpmnC3ejG3E=:G05wN1/uxI6aQICA0bGmrF
 +R4FRLiC0ddXjsyPSjC7hi19ASFI2EQ+04CAE4kvwjzXFgArUWslPEpV/v7UnawH3kEW1mGUJ
 r2Yd3bXmlNX6uQGt3u46UPUa+wyDrAQBNLXpWn6c8Ly2qbqLvkarr0x0N1OSfRWcyhp7Ja1p1
 Hk6Al82zU0qm0jAFrXUwjRCg6ZskdiU+cgEEShWkWLTNIZGuex1dWbIQ+rvcEmFvnxIrPutA3
 6D828HAEkpxYp7x/oHQrwDG138EeRPvDjnjrOqT3QyoJglz+OKP00gAZ6nW9tF1O5MEgVS58n
 V1GMz4M+8TTI4HI740NQ6VlleN95adgsDwTABfAixv7GkILiPJKqcPC3DHVPT++8FX/EGVavl
 r+oDPiTGV1x5Hj/GdoHhpQK/L8J4b+SykG9Ylxkgx4XJEeTk8aaOM8Bff/0r1NdVtyJdtNG6b
 LIpl73MJWKIdNXk1+Ux9np4YomOiJ7BofagjNFZ4qz0H8qh6HYOhimhvxZ3GdpXML6n6F2C70
 O450x91ydAdW9XsxNXicx8=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28.05.21 11:23, Moriis Ku wrote:

<snip>

> +static struct dentry *sdc_serial_debugfs;

Dead code if CONFIG_DEBUG_FS is disabled

> +static void sdc8250_do_pm(struct uart_port *p, unsigned int state,
> +				unsigned int old)
> +{
> +	if (!state)
> +		pm_runtime_get_sync(p->dev);
> +
> +	serial8250_do_pm(p, state, old);
> +
> +	if (state)
> +		pm_runtime_put_sync_suspend(p->dev);
> +}

Dead code if CONFIG_PM_SLEEP is disabled ?

> +static int sdc8250_debugfs_add(struct sdc8250_data *data)
> +{
> +	struct dentry *root_dir;
> +	char root_name[20];
> +
> +	memset(root_name, 0, sizeof(root_name));
> +	sprintf(root_name, "ttyS%d", data->data.line);
> +	root_dir = debugfs_create_dir(root_name, sdc_serial_debugfs);
> +	if (IS_ERR(root_dir))
> +		return PTR_ERR(root_dir);
> +
> +	debugfs_create_u32("bus_number", 0644, root_dir,
> +		&data->data.bus_number);
> +	debugfs_create_u32("device_number", 0644, root_dir,
> +		&data->data.device_number);
> +	debugfs_create_u32("irq", 0644, root_dir, &data->data.irq);
> +	debugfs_create_u8("number", 0644, root_dir, &data->data.number);
> +	debugfs_create_u8("version", 0644, root_dir, &data->data.version);
> +	debugfs_create_u8("resource_cap", 0644, root_dir,
> +		&data->data.resource_cap);
> +	debugfs_create_u8("event_type", 0644, root_dir,
> +		&data->data.event_type);
> +	debugfs_create_u16("tx_fifo_size", 0644, root_dir,
> +		&data->data.tx_fifo_size);
> +	debugfs_create_u16("rx_fifo_size", 0644, root_dir,
> +		&data->data.rx_fifo_size);
> +	debugfs_create_u32("significand", 0644, root_dir,
> +		&data->data.significand);
> +	debugfs_create_u8("exponent", 0644, root_dir,
> +		&data->data.exponent);
> +	debugfs_create_u8("rs232_cap", 0644, root_dir, &data->data.rs232_cap);
> +	debugfs_create_u8("rs422_cap", 0644, root_dir, &data->data.rs422_cap);
> +	debugfs_create_u8("rs485_cap", 0644, root_dir, &data->data.rs485_cap);
> +	debugfs_create_u8("ahdc_cap", 0644, root_dir, &data->data.ahdc_cap);
> +	debugfs_create_u8("cs_cap", 0644, root_dir, &data->data.cs_cap);
> +	debugfs_create_u8("rs422_end_cap", 0644, root_dir,
> +		&data->data.rs422_end_cap);
> +	debugfs_create_u8("rs485_end_cap", 0644, root_dir,
> +		&data->data.rs485_end_cap);
> +	debugfs_create_u32("line", 0644, root_dir, &data->data.line);
> +
> +	memset(data->device_name, 0, sizeof(data->device_name));
> +	sprintf(data->device_name, "%s", dev_name(data->device));
> +	data->device_name[strlen(data->device_name)] = 0x0a;

what exactly is this line feed for ?

> +	data->debugfs_blob_device_name.data = data->device_name;
> +	data->debugfs_blob_device_name.size = strlen(data->device_name) + 1;
> +	debugfs_create_blob("device_name", 0644, root_dir,
> +		&data->debugfs_blob_device_name);
> +
> +	data->debugfs = root_dir;
> +	return 0;
> +}

Can we make that optional (only if CONFIG_DEBUG_FS enabled) ?
Can we use devm_() functions ?

And why not using device attributes for that ?

> +static void sdc8250_debugfs_remove(struct sdc8250_data *data)
> +{
> +	debugfs_remove_recursive(data->debugfs);
> +}

See above: dead code if CONFIG_DEBUG_FS is disabled.

> +static int sdc8250_read_property(struct sdc8250_data *data,
> +				struct device *dev)
> +{
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "bus_number",
> +				&data->data.bus_number);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u32(dev, "device_number",
> +				&data->data.device_number);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u32(dev, "irq", &data->data.irq);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "number", &data->data.number);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "version", &data->data.version);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "resource_cap",
> +				&data->data.resource_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "event_type",
> +				&data->data.event_type);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u16(dev, "tx_fifo_size",
> +				&data->data.tx_fifo_size);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u16(dev, "rx_fifo_size",
> +				&data->data.rx_fifo_size);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u32(dev, "significand",
> +				&data->data.significand);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "exponent",
> +				&data->data.exponent);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "rs232_cap", &data->data.rs232_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "rs422_cap", &data->data.rs422_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "rs485_cap", &data->data.rs485_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "ahdc_cap", &data->data.ahdc_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "cs_cap", &data->data.cs_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "rs422_end_cap",
> +				&data->data.rs422_end_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +	ret = device_property_read_u8(dev, "rs485_end_cap",
> +				&data->data.rs485_end_cap);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Is there some device tree specification for that ?

> +static struct platform_driver sdc8250_platform_driver = {
> +	.driver = {
> +		.name = "8250_sdc",
> +		.pm = &sdc8250_pm_ops,
> +		.of_match_table = sdc8250_of_match,

use of_match_ptr()

> +	},
> +	.probe = sdc8250_probe,
> +	.remove = sdc8250_remove,
> +};
> +
> +static int __init sdc8250_init(void)
> +{
> +	sdc_serial_debugfs = debugfs_create_dir("sdc_serial", NULL);
> +	platform_driver_register(&sdc8250_platform_driver);
> +	return 0;
> +}
> +module_init(sdc8250_init);
> +
> +static void __exit sdc8250_exit(void)
> +{
> +	platform_driver_unregister(&sdc8250_platform_driver);
> +	debugfs_remove(sdc_serial_debugfs);
> +}
> +module_exit(sdc8250_exit);
> +
> +MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
> +MODULE_DESCRIPTION("SUNIX SDC serial port driver");
> +MODULE_LICENSE("GPL");
> +
> +MODULE_ALIAS("platform:8250_sdc");
> +
> +
> 

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
