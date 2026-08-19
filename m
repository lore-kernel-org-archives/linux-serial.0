Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE63B6377;
	Wed, 19 Aug 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141641; cv=none; b=kQKPPemmEylqcPKq7JFk0M+FNdeNDnVmq4rwLvLSRHyFUIeQ6oiKKAriMNq4dJJwusJM3nq1vxa/hgStA9DoQv7y7zvzhVbSwAGxbOAVllyy85AMFZRlOoKTfQgHOdsDVEjkfTgZwjk5qUPb4+2j0V6COwF7vJD3dYprmuLEwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141641; c=relaxed/simple;
	bh=1XiVz5SQEhLDfuBvKMgignom3NNs44iWFERN2cxK6xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEou2Ml2Qc1GZiw2F+YLL811sCXhIBhyJ0lPyzdNUY2vAyHYmUmQZ3VlcKmQyK+HENhmrt2QyFZ2Pqm71rnW9Uu0Rhvv+z+r88SCBe34GFOTq4UdRy3MQQjE6JUNtDbpzgnXN+2ulG9DbV59FjKdnGlPZVYd6pnzgeothTFD+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71edbd6e9bc711f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e49ab339-9e9f-4e84-862b-09c45e0a0945,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:01abf18681c4132f3d95ffeeb0689da8,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71edbd6e9bc711f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1852119034; Wed, 19 Aug 2026 20:13:53 +0800
Message-ID: <c8f3d27a-c8e0-41d0-b8b3-3df783370779@kylinos.cn>
Date: Wed, 19 Aug 2026 20:13:50 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] serial: 8250_mxpcie: set the driver data before
 registering ports
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Gerhard Engleder <gerhard@engleder-embedded.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-2-lilinmao@kylinos.cn>
 <aoVyV8x0HgCrCGv2@moxa-KabyLake-H>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <aoVyV8x0HgCrCGv2@moxa-KabyLake-H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/19 17:07, Crescent Hsieh 写道:
> On Tue, Aug 18, 2026 at 05:39:16PM +0800, Linmao Li wrote:
>> mxpcie8250_rs485_config() looks the board up with dev_get_drvdata() on
>> the PCI device, but pci_set_drvdata() only runs after the registration
>> loop.  Where mxpcie8250_setup_port() presets rs485.flags to
>> SER_RS485_ENABLED, uart_configure_port() calls ->rs485_config() from
>> inside serial8250_register_8250_port(), and the callback dereferences a
>> NULL board pointer.
>>
>> Publish the driver data before the first port is registered.
>>
>> Fixes: d21a1509c623 ("serial: 8250_mxpcie: support serial interface mode switching")
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Hi,
>
> Thanks for pointing this out.
>
> I tried to reproduce the NULL pointer dereference with a CP-134EL-A on
> an ACPI x86 system, but the callback was not reached during port
> registration.
>
> The driver initially sets the RS485 flags to 0x201
> (SER_RS485_ENABLED | SER_RS485_MODE_RS422) and directly programs the
> hardware interface for RS422. However, uart_get_rs485_mode() finds an
> ACPI firmware node and changes the flags to 0x202 because the node does
> not provide the linux,rs485-enabled-at-boot-time property.
Thank you for putting a board on it.

Your analysis matches what the code does: serial8250_register_8250_port()
calls uart_get_rs485_mode() before uart_add_one_port(), and since
6974711cf770 ("serial: Keep rs485 settings for devices without firmware
node") that helper leaves the driver's flags alone only when there is no
firmware node.  With one it clears SER_RS485_ENABLED, and sets it again
only for linux,rs485-enabled-at-boot-time, which your node does not have
- so uart_rs485_config() returns before ->rs485_config() and nothing
dereferences the NULL driver data.

So what the crash needs is an RS422/RS485-only board and
SER_RS485_ENABLED still set once uart_get_rs485_mode() has run: either
the device has no firmware node, or its node carries
linux,rs485-enabled-at-boot-time.  v2 says that in the commit message;
the change itself stays as it is.

I agree the state mismatch you describe is a separate issue.  It looks
like a driver-side decision - mxpcie8250_setup_port() programs the
interface for RS422 and presets rs485.flags, and only the flags are then
cleared - so I would rather leave it to you than guess which of the two
should win.

Thanks,
Linmao
>
> uart_configure_port() subsequently calls uart_rs485_config(), but the
> latter returns without calling mxpcie8250_rs485_config() because
> SER_RS485_ENABLED is no longer set. Therefore, the NULL driver-data
> pointer is not dereferenced on this system.
>
> This also leaves the software state inconsistent with the hardware
> after initialization. The hardware is configured for RS422, while
> TIOCGRS485 reports SER_RS485_MODE_RS422 without SER_RS485_ENABLED.
>
> I also reviewed commit 6974711cf770 ("serial: Keep rs485 settings for
> devices without firmware node") and its review discussion [1]. That
> change preserves driver-provided defaults when no firmware node exists.
> In this case, however, the PCI device has a generic ACPI firmware node
> without any RS485 properties.
>
> The driver-data ordering change still looks correct to me because
> SER_RS485_ENABLED is preserved on systems without a firmware node,
> allowing mxpcie8250_rs485_config() to be called during port
> registration. The case where an ACPI firmware node exists but provides
> no RS485 properties appears to be a separate issue that also needs to
> be addressed.
>
> [1]
> https://lore.kernel.org/all/20251023151229.11774-2-gerhard@engleder-embedded.com/
>
> ---
> Thanks,
> Crescent Hsieh
