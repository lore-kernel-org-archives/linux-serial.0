Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1C3C092
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658551; cv=none; b=e/+PIzZ1pKdm6WbRWDYMVR82EqtGOTou9t4sCIAlcazMN2h6S7SPIDi5iE9agsNPpf8cMxo2VssgShVbZaspSv1HXXz5pxSOejRUR2OVoWhm7HDcbFa1dQf7lwQXvKhh1Xmf1GMjlrXCSkD0nliECGH/tBtPNvi+zA6Ltz4wfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658551; c=relaxed/simple;
	bh=Oj2CWRRWRkWFo+LwN0xtbddwuHvv8HJWOBKZdtyRrro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnkZirKN/jiulm6BcAFb9AZMwQumvCBUs4CscED2hX+h+zgaTpU8gKIXdMBOhAM6m2tnPKLpqcZCeUrt/L6jVN0UCy40PzUUVarl4XdPS73EUnEDP9inQHb2wuQcrq4DvoRozYPko/9r5kM9kd+9aVITL9Pb+M8et/Kr/4f1vyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y346xyu9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y346xyu9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f0cb62068so52635666b.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705658548; x=1706263348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgZff7xJLSEE1id9lwt/xdG/y/Qq+0QfwaWVyXYtpWY=;
        b=Y346xyu9dQ0wetOVxAeuk3h8vgYu8ly+5AU9CjGso6FO0Z+O7WiY1yVxHYJfViGxuK
         IBjQSOF5XCB/owgYmNvXohhGl/jUJc6yLSSBCW4hfEfWkRGLyIHxwg3QBgtjCfPgCztd
         4u4trQyocKDxBKYVJsGlWBW9zr1ftbKLJlfmJnH0K2xO3YVbivYFCmicEnc/cR0TwESR
         X2lm7DPc6U8gY87g/jfiiYJMkuIsFoeNoxCFfERCbUsms8Os6e1HHPcq35/UX+w0KIhj
         oJyQkNAFlDoDjJPbMBuTo8GQtCmyU1bBbsTfbYg2tLdxETLqkTgA8dEWXhfF0PpixNWl
         Ta/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705658548; x=1706263348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgZff7xJLSEE1id9lwt/xdG/y/Qq+0QfwaWVyXYtpWY=;
        b=tAVpS90pwQ0XFyAHTgXsJOImdVO/T879vjUhjj0m52MUFHcTAT76O3KzgG/R7ynWdn
         V6f1M9ibFzGfX7d5lRyFSfhUcbuDWvDN0tZZ2oakzYFNLcqpeINtFzDscTud/LSd67YK
         5m1j2Rn+8EtUyKKBmYX3cDPB0kCuu1bPcBVWz9sKLU7PF8GxfiU89LQaZwnY16ANPm5p
         fZlnJ380LRz3NSmGPV/Ifr/9RIop3iOdt+824Y+HFQkZ3Svgcjq3xxqW5zIvAooFKBEX
         9mkY7HeDH5EPvgXP9IZ5G+ZERZRPS9ISPphrDTdi8jxfnfNfNIwdV5qWL9+OSOcTctLQ
         2jkg==
X-Gm-Message-State: AOJu0YwXnqmcDIQK64SX40EYIW56zQ3Ogjt0O9rmzGUZ8mdqUKYuooje
	408E8BhFynxBUNlFR/zwucG1au2FMy0K3MYqk+Z4CafKzQrd/VN6a8GBPInmBME=
X-Google-Smtp-Source: AGHT+IH3hrSRgqjsIjrRjJE6rvR05Yg3dSlZbAAOv/Cqb6KZ+EaqMYyJPHfW+KG/alUHVseO61EdLQ==
X-Received: by 2002:a17:907:9849:b0:a2e:8379:489d with SMTP id jj9-20020a170907984900b00a2e8379489dmr704850ejc.292.1705658547511;
        Fri, 19 Jan 2024 02:02:27 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b00a2a2426728bsm10179252ejp.178.2024.01.19.02.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 02:02:27 -0800 (PST)
Message-ID: <98b87792-4919-4152-8ccc-b8a731cdfd55@linaro.org>
Date: Fri, 19 Jan 2024 10:02:25 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] tty: serial: samsung: shrink port feature flags to
 u8
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-18-tudor.ambarus@linaro.org>
 <CAPLW+4k091328krLB_KdHyobG-pR--Rt5WaN6c1ccpgdV8ry7Q@mail.gmail.com>
 <76e1dc42-cabe-4925-8aa1-c8f733fb36a2@linaro.org>
 <8f3f85d0-866e-4e5a-8177-05c26c08b278@kernel.org>
 <842d36c7-9452-431f-95c4-ff114484d201@linaro.org>
 <96e3d7e9-737b-484e-bc94-e95533f06ca7@kernel.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <96e3d7e9-737b-484e-bc94-e95533f06ca7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/19/24 09:54, Jiri Slaby wrote:
> Hi,
> 
> On 19. 01. 24, 10:43, Tudor Ambarus wrote:
>>>> If using unsigned int the bitfied is combined with the previous u8
>>>> fields, whereas if using u8 the bitfield will be independently defined.
>>>> So no benefit in terms of memory footprint, it's just a cosmetic change
>>>> to align the bitfield with the previous u8 fields. Allowing u32 for
>>>> just
>>>> a bit can be misleading as one would ask itself where are the other
>>>> bits. Between a u32 bitfield and a bool a u8 bitfield seems like a good
>>>> compromise.
>>>
>>> Why? What's wrong with bool? bitfields have terrible semantics wrt
>>> atomic writes for example.
>>>
>>
>> Bool occupies a byte and if more port features will ever be added we'll
>> occupy more bytes. Here's how the structure will look like with a bool:
>>
>> struct s3c24xx_uart_info {
>>     const char  *              name;                 /*     0     8 */
>>     enum s3c24xx_port_type     type;                 /*     8     4 */
>>     unsigned int               port_type;            /*    12     4 */
>>     unsigned int               fifosize;             /*    16     4 */
>>     u32                        rx_fifomask;          /*    20     4 */
>>     u32                        rx_fifoshift;         /*    24     4 */
>>     u32                        rx_fifofull;          /*    28     4 */
>>     u32                        tx_fifomask;          /*    32     4 */
>>     u32                        tx_fifoshift;         /*    36     4 */
>>     u32                        tx_fifofull;          /*    40     4 */
>>     u32                        clksel_mask;          /*    44     4 */
>>     u32                        clksel_shift;         /*    48     4 */
>>     u32                        ucon_mask;            /*    52     4 */
>>     u8                         def_clk_sel;          /*    56     1 */
>>     u8                         num_clks;             /*    57     1 */
>>     u8                         iotype;               /*    58     1 */
>>     bool                       has_divslot;          /*    59     1 */
>>
>>     /* size: 64, cachelines: 1, members: 17 */
>>     /* padding: 4 */
>> };
>>
>> What's your preference?
> 
> bool :).
> 
I'm fine with a bool too as since the introduction of this driver we
have just this flag, it's unlikey to have 4 more soon to bypass the
first cacheline. Will change to bool.

Cheers,
ta
