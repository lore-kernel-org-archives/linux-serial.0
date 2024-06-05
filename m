Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FB190463;
	Wed,  5 Jun 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569302; cv=none; b=bF5eHItQE9SutR4rUlPeyQK37Ayj+jS+SFg7FgO8i3FcldMeBH55T34Me7urWmjW4G5CgItJ1nUDSbJc97L0M/+dMP+w3zqLRMZOLs859w9AdILugxFTu+noE8XQ5E/mf3zSB8CWPIDHJJFQ9dwjIECQdrHwik96f8FisQMr3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569302; c=relaxed/simple;
	bh=poZ3fccdp9nDd6a0bF/SLXnzovyXM+TeTVI2e5/lsSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5zCN7RwJluqV/ahLImxXyo1S/3p5ltlik1IXAeVTSebwAi9sHc5Del6vGiVFAAR8hLtXQtMAaShlHXW9VPnbZ4sFdNMJwuxNwtDwsTDi4cuMz82YcJRXY002gztWaFbGNZ8e5nBowYj1bE1AwHZDATKXza2wf2/lvMj2gZ9TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AmaqHK9r; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AmaqHK9r"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 31A1640FA2;
	Wed,  5 Jun 2024 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717569298;
	bh=kXR4zeNZkSRcOX4xy4tM101VrJ2NmLIfGWhKx2PTf/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=AmaqHK9rdquVWYGiwyrInxDnS6saH0BztqZNoNTiW3MMcPd8k4kPm0tjK7dm472IV
	 vrobFyjnLkCIz/6DLFUkPvFVGk258dA86AoOAWYeOw39jZrHOgh9sDlv/F51IytsZv
	 JMN2ipfd26tWiM4fQP8eZfPom4j36jLdknvIsRAhDZSkqLMEFg8DYL+Q7yUyrwlKSh
	 MU8E5S0jRZwixu201OMKyG2iye/0mmDe8JCV4ppmKEG6cb5YaUT3126F4DyjItE1UO
	 6HTGog5J5+xb1nUSBUxuxklOVGgs2CUBkAcj7e2WVuvAWV7yLGQ/jW57C8Rl6ad8zT
	 54RjkgFr0oq3g==
Message-ID: <52e66854-0356-4ea3-81e5-33bd17819873@canonical.com>
Date: Wed, 5 Jun 2024 14:34:52 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604103538.a96cef712dcff156eca099b0@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240604103538.a96cef712dcff156eca099b0@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 22:35, Hugo Villeneuve wrote:
> On Tue,  4 Jun 2024 21:27:25 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
>> In some designs, the chip reset pin is connected to a gpio, this
> "and this ..."
>
>> gpio needs to be set correctly before probing the driver, so adding
> "so add ..."
>
>
OK, will fix them in the v3.

Thanks.

