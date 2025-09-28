Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A01C6A3;
	Sun, 28 Sep 2025 03:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031747; cv=pass; b=CWq2TeLMwPh2Ge/XFqRGLOYRUhxV5kE1VA4zLU09DGp7VGrcHuSMmKzrI4Eu47xyjDMvbADV+NG8mHKlcMgAiHKPl9NJoqE4oqri764UdXA+ou/twuxaaRc0YCQFxsZtbA/TyluLFN6XtgfPnVyTIBDzqdstubuxJFg88rCa/nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031747; c=relaxed/simple;
	bh=T21jfvNUaKJtai3h1JBCeUbst1A5RiHxfpTitoitGtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fco0FgHE3ukFyEW0KRy2BKhEuvTVch1laj1m3J15eXbaPrscAXKQnUnM3b33fdo5H/UwnAyldX/ITC9FKFizn0Ko//Jt8I9kLMaeEpIRke4S2KtEWF+mxaiuTii1ahFIHLyu7d2I5ucbITkEfv2htFOp6yfEbJvn066Xo+sdJ9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=Hi2KCnO8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="Hi2KCnO8"
ARC-Seal: i=1; a=rsa-sha256; t=1759031705; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TXfimD2q560aPLho43hi6Uuxe4qW179hIPP7duab3tYoOPl4/vdK1N3N9Ev6u1Mzbm6g3BoD+kn/IBbD/4zEECtK8eld8h4zkBetmzM6Vs8y24CMfbl2lJ/ivkF1MswtYpDA58KLRJyHRf9PlSKr3D26e8Vh5mkqeOewG9TrlvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759031705; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tKfnmneuohN8coB1a+XGSw3Os4lO+rOJEhg1bdS4Bz8=; 
	b=fPYT5e4/upYb5xdhouQr/mRM3SIn7M8i76Ia08te8OtWYHjoPBryTcbLS+zVGS77IUqWtQBg7tsuf53TRufWN8lIPEUjjFODNztz3wR/luMEkPcZ7z/TLoz9JuZ8tsDG8bf7hDlD8Bsl8EHHc6Z0cgS8ibWKlOK9RZ1O6Ryi0N0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759031705;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tKfnmneuohN8coB1a+XGSw3Os4lO+rOJEhg1bdS4Bz8=;
	b=Hi2KCnO8kZjT+5DHvNRBl89zKzpUDfTXWV5rkkForhdx3w6DPQp5WDvbt4UhUXqr
	jo/9HWV/xKBAHE7dn3XWaoJJ8sEUsAaU3/CbD/g5c+mLwD7Tf2145O/6XXFgu0bs2fi
	vKoGQiRHSULVmGoLODHlZ14OheQXUMKMUBrrgmjo=
Received: by mx.zohomail.com with SMTPS id 1759031692647275.44505116756466;
	Sat, 27 Sep 2025 20:54:52 -0700 (PDT)
Message-ID: <416407c8-9af0-4331-beaa-f53e1a5cd427@pigmoral.tech>
Date: Sun, 28 Sep 2025 11:54:42 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] dt-bindings: timer: Add Anlogic DR1V90 CLINT
To: Qingfang Deng <dqfext@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
 Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
 <20250927135912.3327-1-dqfext@gmail.com>
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <20250927135912.3327-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Qingfang,

On 9/27/25 9:59 PM, Qingfang Deng wrote:
> Hi, Junhui,
> On Mon, 22 Sep 2025 20:46:34 +0800, Junhui Liu <junhui.liu@pigmoral.tech> wrote:
>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> @@ -29,6 +29,7 @@ properties:
>>       oneOf:
>>         - items:
>>             - enum:
>> +              - anlogic,dr1v90-clint    # Anlogic DR1V90
> UX900 uses the ACLINT with SSWI. Please use the new ACLINT binding.
>
> Link: https://www.nucleisys.com/upload/files/doc/Nuclei_RISC-V_ISA_Spec.pdf

Thanks for pointing it out. I will verify it in both Kernel and OpenSBI,
and update in next version.

>
>>                 - canaan,k210-clint       # Canaan Kendryte K210
>>                 - eswin,eic7700-clint     # ESWIN EIC7700
>>                 - sifive,fu540-c000-clint # SiFive FU540
>>
>> -- 
>> 2.51.0
> Regards,
> Qingfang

-- 
Best regards,
Junhui Liu

