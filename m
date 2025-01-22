Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7016BE3A
	for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540564; cv=none; b=jsnzhC0Vle4zd2LzeOEoTe/q3ZLdfMo484pSJMVF+xwwUvZLuJIlWg8lhaP6NzH/xZzV6xQj2N1ecV7wDxNkyDQMSQ3tu8Vx2rJFMXs6fISZQE6Nbk++NYAnyxoNG7qrKj8327ffTozS5bzKQk+EL/s9Wi6gW98kmIeVcmgvyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540564; c=relaxed/simple;
	bh=yPq21HhdpDlsS14IAW4zQa5skvQJ+MdKpDAy9He2FlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flmDYJbxD7xUQeliYospe0pVcAR+VVRPKD1A83zXkw4uE2d7p19ATcs+U8LFRqxVK7RgUvnKE8wwuHwowVsjfFGj2abkK9hp3rbGBfKCi6sVaNr4JiD9znv0oeC/8ApH+CdG/uSYVEJ3rr1m7ZcUJx3IHnw6Wth14gqkZ1ZPMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KFzA9LSz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KFzA9LSz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab322ecd75dso142131266b.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737540560; x=1738145360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEJEd8faAZ8pH7yQQA5pi8eTwG/AqywjNq66uj965H8=;
        b=KFzA9LSzGHuyRlka6fwEMjxvVr3860d2TvLHD90/5cziuFiBS3V4zt60ktvNZBH6w6
         5CR8OsOR2D8FKMfWQYTsNgmNjUDaqUmbnQooxqXCsDS6dreovqO8xx9eLxwYdpIEQxdv
         26EfRSIjj5EfghdyxOV1ZfUgNgWrtOkuyocInLGEaHP4802Iw6SuUoxqMnfVbMwr6ol1
         cjd96EjmGUu0n3TXrczLwWmzaHlbHouFSUjjLAEE12BRXv3PLU9oE6sfdfDVsquJTpmX
         fbRgp36E8aDXedMkE/kkNjigbNzLV0hI7Qo6X1T+mPhOfklnROmQvDWpnmfBaJKcdDC7
         VzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540560; x=1738145360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEJEd8faAZ8pH7yQQA5pi8eTwG/AqywjNq66uj965H8=;
        b=ojzCyDUf808RCnJXKkalZMUQFf2T1FJXv1SkYnr5bIs02uwjd5gjerpKq4gNjKUODp
         rJ5l1olwalBgDrMyAPaO5vVCnksV4qScpyKc4l4ynr5Cte8Y3nkF8pk1kUwD3qr0AjbT
         M4ZCNg1ZPpvrVJUm79rz8Cp1hN/pYZGAPhDiM3nzBFYUT8r2Q+TcI11kFKOYvYu4q9hJ
         KlmZTUcKdxR+o0gjsFYronjWE9SOgcnNKF8l5JUMLVTI/RzvlzL5fJ+9tvWzzmC/XEVs
         C03XfV1OEwXDBPoEU50tjswJhjg47Kmsrk3D8Fj6OdVEfR5LhFUDkgdXecUKI0R1UteU
         FRQA==
X-Forwarded-Encrypted: i=1; AJvYcCWN1Bsqf4Watds92+TW+YwgU1Qjppfv0b0tN5rv+qfkPc3GAC6XHJxdMq3IQFUKH5mutB9Qiq0BeNB3KBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeSdumjpetC5UXAbXYf22o2qQkt5pYLhjICqT3JP7qo1tOXAp
	S8tsEz2q/5Pr0sEIwJOJ31njUfEbCx+7oQnrnqRu1kiC2O3rW0LNOMeCqyrIvf4=
X-Gm-Gg: ASbGnctai8iEE6WOJTs65GhPqqJH/ZN+jZ7c/Az2wSOSBb4LM6TU9iq8N7Q/4o62Ovd
	pfvdlFNAZzL9ZPlzX4nQFJtS9tZnATzAPJDQsng5j/zmwJQrg8Iy7VcaEgZ2TSBeXhaXdBe4qKP
	bEZB4jdHEY2NaRxOFyIYWaWk0J6YHGrvGxMSD/mYJE0Mz8obHhrhM6ilsta6YgvuYkLHeedNp9z
	9iOiL+NuJX7rJViOQg9NkLLH9+IQleo4Jm6v906g4dxBnqbQBoii2j2XbO/SzyZL/A2Lmiuhwfv
	iQ==
X-Google-Smtp-Source: AGHT+IFVRPmudokZEYxl+UG1fyhtE2C6e0Eu/TY6D7Z3irDR1ZjFtdV9zGTdFMCb5huVLQghs03L8g==
X-Received: by 2002:a17:906:f596:b0:ab3:47cb:5327 with SMTP id a640c23a62f3a-ab36e19cff2mr2054334566b.5.1737540559995;
        Wed, 22 Jan 2025 02:09:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1f71sm893158566b.61.2025.01.22.02.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:09:19 -0800 (PST)
Message-ID: <c7e34ef0-b094-456a-ba68-2709ff7cec13@tuxon.dev>
Date: Wed, 22 Jan 2025 12:09:17 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] serial: sh-sci: Update the suspend/resume support
To: Krzysztof Kozlowski <krzk@kernel.org>, geert+renesas@glider.be,
 magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 p.zabel@pengutronix.de, claudiu.beznea.uj@bp.renesas.com,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
 <20250120130936.1080069-2-claudiu.beznea.uj@bp.renesas.com>
 <04fde244-006f-4bda-9d65-7957be74f049@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <04fde244-006f-4bda-9d65-7957be74f049@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.01.2025 10:54, Krzysztof Kozlowski wrote:
> On 20/01/2025 14:09, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S supports a power saving mode where power to most of the
>> SoC components is turned off. When returning from this power saving mode,
>> SoC components need to be re-configured.
>>
>> The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
>> returning from this power saving mode. The sh-sci code already configures
>> the SCIF clocks, power domain and registers by calling uart_resume_port()
>> in sci_resume(). On suspend path the SCIF UART ports are suspended
>> accordingly (by calling uart_suspend_port() in sci_suspend()). The only
>> missing setting is the reset signal. For this assert/de-assert the reset
>> signal on driver suspend/resume.
>>
>> In case the no_console_suspend is specified by the user, the registers need
>> to be saved on suspend path and restore on resume path. To do this the
>> sci_console_setup() function was added. There is no need to cache/restore
>> the status or FIFO registers. Only the control registers. To differentiate
>> b/w these, the struct sci_port_params::regs was updated with a new member
>> that specifies if the register needs to be chached on suspend. Only the
>> RZ_SCIFA instances were updated with this new support as the hardware for
>> the rest of variants was missing for testing.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - none
> 
> 
> Why are you combining serial patches with DTS? Greg applies entire set
> thus you *cannot* send him DTS.

It's v4. The initial set contained fixes for serial, support for RZ/G3S
(including clocks and dtsi), all that was needed for the enabled RZ/G3S
serial IPs. Fixes were posted separately (as requested), the other bringup
patches were integrated and this is what remained. I chose it like this for
version continuity.

Thank you,
Claudiu

> 
> Best regards,
> Krzysztof

