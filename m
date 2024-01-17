Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8733225AF
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511758; cv=none; b=AN40iKMfQIvolPLGZgiMt20nRpj92wC/l5iU41f8GpVaPQ7wdUdjUkPwK6rAQtewpy+HfueG8g9MAnI2U8/6cmEK1x+0qtET0lBnF9IeyzLDxqpM6guq+NC/szbVS0YQ4gh34Jw40Sno2kZMtUp2bzAnsOs2NMI7YzhC4JzIfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511758; c=relaxed/simple;
	bh=uoW4HUk29kpHj68SF+hGOItA0f/Gp6jWrZH8lGth7lA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=bOAfJC4sju231/OkLozkoA2XTlF5uiVJ9EDocZp4R8SIAArGq0dNGK5Hf75Mo6MbhKmETPNRCNIBVQH1ZF6kFS9WQ74EDHmAJRphsR1Q4UhDlQDNXVIi768HKAtGRvZDGXlCEs3DVBSwayDWfY6C5tvOtgMw27Z6goiv5O2bHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jd8j/BYi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd8j/BYi"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so13794470e87.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705511755; x=1706116555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVT3PU0cW+s0avKE1jP7V15SsbgqFqqu1SCavUYDkpg=;
        b=jd8j/BYieIlPWzg7JmauE5LwpiuFwPC5Rk4fAzgUuPlZtkAPWUZxEXtQds/45HntDG
         JoVq6QJduHfYpD6F0oyhllf9uKUehmiNbC37eMEvuXY7xXvXqp6Q5lB538qH/NnOs5N1
         qfLnZG2BMquOCaRbWlcxJEyOaN60P823K5DYhTQ+CV0uff5Tve83UJA+s9n/iGchBtRq
         TBoL8vxRW8ouFUTKnDzpVfmiDyw3z01ypTEP0hhW4pDTPBbDE5Z4BwUWmTsYrHIwYM40
         eBuBAgpNbPb75yS9AxZSN4aJi+tm/8b+aLJ3buS2+qYk/GTPB4GoUMqXFJTN9aSvdsRw
         MB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511755; x=1706116555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVT3PU0cW+s0avKE1jP7V15SsbgqFqqu1SCavUYDkpg=;
        b=tGgMOllniFCm9kJ8fJiWRvxe8VslSD0wnoK56xyvBgG5qDbNfLORheAYUHbdDuxQTG
         Cjuqm3JXzZP6vTFq3Ei9siKR0MqPsxhYN+VnZra+mxCErqD+npeH1/dSqej/xrkmHECE
         /Xti3wCFlUMD/KYqKJRw+dh4O5yWK+ei7CxEvtTgWnrBNNxrfuFY7z82pguakBOz8Dc3
         6gatwE4pXGzCzRYuA5e8Kiy3hdUbXyqAzTPKLG2W53xslJ9AxZeEAww/WWaqdFkI+Bye
         RfZQYkfz6mA3xJjEm8yQhN0NmEbHQD8kxeAstL2CV1u5t9AQQHiURVQNfMoWLgZmxfzh
         rTuQ==
X-Gm-Message-State: AOJu0Yx7/eLeLTdXnK+2r5BSrRyTN4FaORasE2HV7fwtHVms+Ii1dzNv
	ZNVvl0MfcojKmr+R+eG0LjUugcXnUbPNFg==
X-Google-Smtp-Source: AGHT+IGBUV0P9JgYWmc06edXGkUIL1yy8hFL2bGz5t8Trptc6qb405fVHccjXHsBBVlQawuu97nrgA==
X-Received: by 2002:a05:6512:15a9:b0:50e:b3ae:dd67 with SMTP id bp41-20020a05651215a900b0050eb3aedd67mr4915092lfb.2.1705511754673;
        Wed, 17 Jan 2024 09:15:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090612d200b00a28fd9607a8sm7958704ejb.81.2024.01.17.09.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:15:54 -0800 (PST)
Message-ID: <e57d7f34-3abe-4860-8986-0cb7070819a4@linaro.org>
Date: Wed, 17 Jan 2024 18:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, robh@kernel.org,
 alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 gregkh@linuxfoundation.org, imx@lists.linux.dev, jirislaby@kernel.org,
 joe@perches.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
 <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
 <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
 <Zaf+Gn6rYstttnrA@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zaf+Gn6rYstttnrA@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 17:19, Frank Li wrote:
>>
>> Not really, because compatible describes hardware and it is the same
>> hardware here. We do not have two different compatibles for GPIOs being
>> input or output.  Or two different compatibles for serial engines (ones
>> providing UART, SPI or I2C).
> 
> GPIO and UART is simple. Actuall SPI and I2C have two mode, slave and

I talked about serial engines which can be multiple: UART, SPI and I2C.

> master. Many SPI/I2C is dual mode controller. Just seldom use slave mode
> at linux side. So you just see master mode SPI/I2C controller in dt-binding
> and dts file. So few people upstream slave part to linux kernel community.
> They have the exact same problems if support slave mode.
> 
> PCI is typical example: 
> EP mode:  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> RC mode:  Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> 
> Which is the same hardware for two difference compatible string.

That's the only case, I recall.

>>
>>>
>>> I can write git commit message like:
>>>
>>> dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target
>>>
>>> silvaco i3c controller is dual mode controller, which can work as master
>>> and target mode. All clock, reg, irq are the same for both mode. Add
>>> compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
>>> controller work as target mode.
>>>
>>> Of course, alternate method to added a property "mode" to distingiush
>>> master and target mode. but old "silvaco,i3c-master-v1" will actually work
>>> as dual mode support. Driver structure will become complex.
>>
>> Please send full DTS of user for this, which works for 100%, so we can
>> see how it differs from controller mode. If your code snippet from other
>> thread is correct, then it would suggest "mode" property or lack of
>> children. Maybe lack of children is not enough, if user-space could
>> control I3C bus.
> 
> According to current implment, only need change imx93.dtsi's @i3c1's 
> compatible string to "silvaco,i3c-target-v1". I attached imx93 dts node for
> your reference.
> 
> 	i3c1: i3c-master@44330000 {                        
>                                 compatible = "silvaco,i3c-master-v1"; 
> 					     ^^^^ only need change here!

Nope, don't change compatibles of existing nodes. Unreadable and
unmanageable code.

>    
>                                 reg = <0x44330000 0x10000>;                
>                                 interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <3>;                      
>                                 #size-cells = <0>;                         
>                                 clocks = <&clk IMX93_CLK_BUS_AON>,         
>                                          <&clk IMX93_CLK_I3C1_GATE>,       
>                                          <&clk IMX93_CLK_I3C1_SLOW>;       
>                                 clock-names = "pclk", "fast_clk", "slow_clk";
>                                 dmas = <&edma1 6 0 1>, <&edma1 5 0 0>;     
>                                 dma-names = "rx", "tx";                    
>                                 status = "disabled";                       
>                         }; 

That's not a patch for existing file. I did not claim you cannot write
such DTS. I claimed you don't have such DTS for upstream...

> 
> For master mode:
> Unlike i2c. Genenally I3C can auto probe children node like USB can auto
> detect attached devices. So I3C master can work without children nodes.
> Such as auto load i3c sensor driver according to i3c standard vendor id and
> production id.

Then presence of children cannot be used.

> 
> For target mode: using configfs to controller I3C.
> 
> mkdir /sys/kernel/config/i3c_target/functions/tty/t
> echo 0x011b > /sys/kernel/config/i3c_target/functions/tty/t/vendor_id
> echo 0x1000 > /sys/kernel/config/i3c_target/functions/tty/t/part_id
> echo 0x6 > /sys/kernel/config/i3c_target/functions/tty/t/bcr
> 
> ln -s /sys/kernel/config/i3c_target/functions/tty/t /sys/kernel/config/i3c_target/controllers/44330000.i3c-master/
> 
> Then you echo test >/dev/ttySI3C0.
> 
> Unlike USB, user can switch host and gadget mode dymatically. Suppose I3C
> only work on one of master or slave mode only, which is static.

I don't understand this. So it can switch dynamically or not?

> 
> Although it is one hardware, I think it is exculsive multi function device.

Just like serial engines. Do you see there replacing compatibles? No.

> 
> Summary: basice two option to distingiush controller and target mode.
> 1. by "compatible" string
> 2. by "mode"
> 
> I think 1 is relatively simple and easy to understand.

Eh, if you only saw my comments on people replacing compatibles...
Anyway, I stated my reasons, so to reiterate: NAK.

Best regards,
Krzysztof

