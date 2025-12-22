Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF91D432D
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401238; cv=none; b=pPpXgSdL5W6j2vYTf6S0xy0xtatGYa4yc8U4oS1Zo90TnZULFErtK8cVqHNMFS/Ogq8DLqxFiEwyIOvB8V5WhB1w6b64djBJlYm/S+5luNzUfvaBQgOlhcvI/RqjUfWCIiF8OTYYCOXX7K9SwA/KHT6w68dP9S1cfpC4lmTz8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401238; c=relaxed/simple;
	bh=YHcOp1ha1dADHNlG6yKhN0g91FKH2BRMqMEo6+TUCVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MR7w2b1RrtJDSzRAUyR6ZLJeLrxIlAifKGk9h4qeuf3rbhIPSyJZGusfFkCENRjc+QUmNFTKZi7rEJ4hcD1xavujXXmDqnEVLiqzJYx6EYQVUVDiKsAZgNrcDnFt5FXfUmDVmmosSjfe2Nj3L+yIijpC7t7kdpmwVpmIBr8u1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J2q5dvt2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J2q5dvt2"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251222105527euoutp01d44a94c53c8865bf82283706292218ca~DhEjxAQYf1952119521euoutp01-
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 10:55:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251222105527euoutp01d44a94c53c8865bf82283706292218ca~DhEjxAQYf1952119521euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766400927;
	bh=GIGramMDqDYFO1ODsYML0/yFX7CTG/8LyI1iMXjysB8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J2q5dvt2xXtKfnT9O9vwF7NjHX9FhiAdD2ATtSqo0V4wuRQonJks8zptVkSxljovs
	 YGhROafBk0D406ZADjqtkF3k+AU9zVrKe036+B0Eca1GOPpCSa2u3uIMBy8jLkfDLQ
	 Vy0nv5zPbv9P0RXoyhm/XeRkaWKLQoSLUcn8kZDQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251222105527eucas1p2bad3f1b183d3a7fa2ad45361cf8a1512~DhEje0BdN2143621436eucas1p2J;
	Mon, 22 Dec 2025 10:55:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251222105527eusmtip16cdb0beed89e9aceacb1816ae6a37320~DhEjLQ6141377413774eusmtip1g;
	Mon, 22 Dec 2025 10:55:26 +0000 (GMT)
Message-ID: <361ad06d-0478-40f9-9894-6f53d7b27eff@samsung.com>
Date: Mon, 22 Dec 2025 11:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <713aa37f-161d-4f08-9417-d7d2abdcdfd9@sirena.org.uk>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251222105527eucas1p2bad3f1b183d3a7fa2ad45361cf8a1512
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13
X-EPHeader: CA
X-CMS-RootMailID: 20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
	<CGME20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13@eucas1p1.samsung.com>
	<265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
	<713aa37f-161d-4f08-9417-d7d2abdcdfd9@sirena.org.uk>

On 18.12.2025 17:54, Mark Brown wrote:
> On Thu, Dec 18, 2025 at 04:29:55PM +0100, Marek Szyprowski wrote:
>> On 27.11.2025 17:36, Andy Shevchenko wrote:
>>> The change that restores sysfs fwnode information does it only for OF cases.
>>> Update the fix to cover all possible types of fwnodes.
>> This patch landed in today's linux-next as commit 24ec03cc5512 ("serial:
>> core: Restore sysfs fwnode information"). In my tests I found that it
>> breaks booting of most of my test boards (ARM 32 and 64 bit).
>> Unfortunately I cannot provide anything useful besides the information
>> that booting stops and system doesn't reach shell. There is nothing
>> suspicious in the kernel logs. I suspect a memory trashing. Reverting
>> $subject on top of linux-next fixes booting.
> I'm also seeing this in my lab and Arm's lab, there are a few systems
> that survive but it's a small minority.

I have a few spare minutes and spent them analyzing this issue.

This is somehow related to dev->of_node_reused device property and its 
check in pinctrl_bind_pins() in drivers/base/pinctrl.c.

The following hack/workaround fixes the observed boot issues:

diff --git a/drivers/tty/serial/serial_base_bus.c 
b/drivers/tty/serial/serial_base_bus.c
index 8e891984cdc0..f3332a5e134c 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -76,6 +76,7 @@ static int serial_base_device_init(struct uart_port *port,
         dev->release = release;

         device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
+       dev->of_node_reused = true;

         if (!serial_base_initialized) {
                 dev_dbg(port->dev, "uart_add_one_port() called before 
arch_initcall()?\n");


If I then remove the dev->of_node_reused check in pinctrl_bind_pins(), 
the affected boards don't boot again the same way. I hope this helps 
fixing this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

