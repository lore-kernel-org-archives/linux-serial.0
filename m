Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554F267AF6
	for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071804; cv=none; b=gnbIoUBKz6LFmI/O4DUnSGnCSzuLF/TZq+F9XV/ggbu3Jp48VmWNzrJsTVzhO72Y2YoV1Q6G7Y1/u3o0kvtaGd64YUMTXGRQBE7Di0BVDI+Mm5mTw+pPjRzSxHL+l4TC0yTnhSoxdzBDxkIrbb/5/ewwbQp3sFHVReVxesOBvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071804; c=relaxed/simple;
	bh=23vKUbDZimVX+GAlYEGcjICX6YzwTMlTvoey/WTrdwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ek/pGX81lxt+uEx+T0cfyrE7TsHM9HP0ECiAkIWOLUsKIbReOxShodO6RsIqXvIgC5Y1ENQDMsZf5lTBP/AgdDPb7ED7LCBu9qHgCInvIkUbxKClob6Pkw0+y6Imi4Cn92TkvAE2JgOlVQAhW2EL2qViY5ItWglMwgXVgjqksUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OlgS6xvW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OlgS6xvW"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251218152958euoutp02de599c552f274de3fe8a13c32b2b7a29~CWPGLb9Qj1155011550euoutp02o
	for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 15:29:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251218152958euoutp02de599c552f274de3fe8a13c32b2b7a29~CWPGLb9Qj1155011550euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766071798;
	bh=x82MWVwXJ1riRllywZ3gguLCC2lxvxMZcC75yxfE/38=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OlgS6xvWxXfXEo6cyN4lultvkFCIfN0WQxwNc1hOanNCkiVbkEJHElJYvMWgK8IJk
	 yUEy+37v4ic63IjRDiUgDp93LdyLmXkkKOfU7IFta5aPWDmwugBjp5ELxoifxzZ10u
	 UGohPafSV9MF6pgcrtLuJtsm6tRotht1ph55lQGA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13~CWPFPwoNp1282312823eucas1p1m;
	Thu, 18 Dec 2025 15:29:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251218152956eusmtip20b5bb47b0966fdb48b5a799eda18a258~CWPE6fRvB1546315463eusmtip29;
	Thu, 18 Dec 2025 15:29:56 +0000 (GMT)
Message-ID: <265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
Date: Thu, 18 Dec 2025 16:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13
X-EPHeader: CA
X-CMS-RootMailID: 20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
	<CGME20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13@eucas1p1.samsung.com>

On 27.11.2025 17:36, Andy Shevchenko wrote:
> The change that restores sysfs fwnode information does it only for OF cases.
> Update the fix to cover all possible types of fwnodes.
>
> Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

This patch landed in today's linux-next as commit 24ec03cc5512 ("serial: 
core: Restore sysfs fwnode information"). In my tests I found that it 
breaks booting of most of my test boards (ARM 32 and 64 bit). 
Unfortunately I cannot provide anything useful besides the information 
that booting stops and system doesn't reach shell. There is nothing 
suspicious in the kernel logs. I suspect a memory trashing. Reverting 
$subject on top of linux-next fixes booting.

>   drivers/tty/serial/serial_base_bus.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 22749ab0428a..8e891984cdc0 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -13,7 +13,7 @@
>   #include <linux/device.h>
>   #include <linux/idr.h>
>   #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>   #include <linux/serial_core.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -60,6 +60,7 @@ void serial_base_driver_unregister(struct device_driver *driver)
>   	driver_unregister(driver);
>   }
>   
> +/* On failure the caller must put device @dev with put_device() */
>   static int serial_base_device_init(struct uart_port *port,
>   				   struct device *dev,
>   				   struct device *parent_dev,
> @@ -73,7 +74,8 @@ static int serial_base_device_init(struct uart_port *port,
>   	dev->parent = parent_dev;
>   	dev->bus = &serial_base_bus_type;
>   	dev->release = release;
> -	device_set_of_node_from_dev(dev, parent_dev);
> +
> +	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>   
>   	if (!serial_base_initialized) {
>   		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> @@ -94,7 +96,7 @@ static void serial_base_ctrl_release(struct device *dev)
>   {
>   	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
>   
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>   	kfree(ctrl_dev);
>   }
>   
> @@ -142,7 +144,7 @@ static void serial_base_port_release(struct device *dev)
>   {
>   	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>   
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>   	kfree(port_dev);
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

