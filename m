Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F623595D
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760902379; cv=none; b=FBkE/S7jSF5wV1M0SRaSaNm5xgIIIIXa0+SvHJVfnpeU/RCIeyeV9qhnREohRNrD7kf/SMxND7OCcfutB7uKUnMcFzUb1/YO0IepOyPmh6rGVrFWP88L4b8j5syxEfQOjj1AVhRX0BVERKZ/bNRNnMd0mo6caQ+jetHGtYw1N8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760902379; c=relaxed/simple;
	bh=JfRuGTQi+Je6BEDxRILCYQ0xhaH5Ko+xxQOYHIl14bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBQ/on7M3c3Rb/JdXJLBM9AWP8bp92IC4J7dm6Oo0TEoxrzRlnaqFcyTc7QGm0314V3ZWfZPAhiIkaia/f4NjakOZNrOMYa+IZmOpWljpNNx7rsj/dCUsVHe3/LyFWka4rMNVUFvd/7jR3MIA0Ock6G8nicXlYctcpCjHfYrgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=jj+Zo+rp; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="jj+Zo+rp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rali4VEq6pb6bWIz/OaHDrgY1tYTOarahQNr1moB07U=; b=jj+Zo+rp0iV28m2Rkrrxd10fFu
	FKQrexdUAbAouetjQ6lJcvJwnQxuWX+CO2EtYjoeLaaiM1uESLxnCbJ7nxAAUiFqKa0RUFeuTWTHF
	TLk+1CDB3MpnaYUdKcoRLQzpYG39jkyReHmYHC3QZEOQETRlmkDncjchlWMV0lHdJ1So=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAYjv-000000002DU-0Qeo;
	Sun, 19 Oct 2025 21:06:47 +0200
Message-ID: <f1588575-e57c-4648-baa9-951739a906f5@engleder-embedded.com>
Date: Sun, 19 Oct 2025 21:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
 <aPSmOcbprjf0EoAq@wunner.de>
 <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
 <aPT42ykVKxouqUHK@wunner.de>
 <4e3da3b9-693e-4d21-901e-14ac4663d340@engleder-embedded.com>
 <aPUZlCFq4c3oQC53@wunner.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPUZlCFq4c3oQC53@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 19.10.25 19:02, Lukas Wunner wrote:
> On Sun, Oct 19, 2025 at 05:21:30PM +0200, Gerhard Engleder wrote:
>> On 19.10.25 16:42, Lukas Wunner wrote:
>>> BTW is there a good reason that you don't have a fwnode for your UART?
>>> It seems odd to have a UART but not describe it in the devicetree.
>>> Maybe that's the real problem and fixing it obviates the need for this
>>> patch?
>>
>> This auxiliary device is part of a FPGA based PCIe device. It is mostly
>> used on x86 but arm64 is also possible in the future. There is no device
>> tree or ACPI information available for this device. Think about an x86
>> CPU module where you cannot influence the BIOS implementation and device
>> tree is not available. IMO having a self describing PCIe device which
>> works out of the box is best in this case.
> 
> It would be good to have that information included in the commit message
> to avoid head-scratching by reviewers and leave breadcrumbs for people
> who happen upon the commit through git blame etc.

I will enhance the commit message.

Thank you!

Gerhard
