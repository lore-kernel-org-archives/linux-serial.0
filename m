Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DD7E0FF
	for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629331; cv=none; b=U9b6jnSZZWhfdBapDOjpYzvFF0lvLmXYehnYvlVdT0aINhSmLDSVBf3+Fl+0qMtA5+h9sfbHIQSj3TH4/QmqoGu9NGFoTwRaZXa6PGfHmfZSeDCYkS3mwJksSU7OwfavckgEBNx/hGCbgh3OcLTs/zfXFuQxgf87qigCe9odVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629331; c=relaxed/simple;
	bh=/u+EHZhPX7ZUWzslCdo92AaoP1R77aPK1GR/RmbeY2w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SKssmuGL47LTGWjeOsavqbOCzpw+HD0hHftZsD4DQc+MXZHpDRpDCq39r4kPVkEgarOppP6XslclPH/Z/zwQSRbwkknKD385c2GLj35TCsmm753CBTAio/DqnEW55P8+vJ//u2VofnHA1dV+yPlsosPhS5FAWAMM4D5PdB/pWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiffD4wm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiffD4wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711629327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5ORqLKh8/XLA09MZvXXVlo+iCvFUPkDkTTQOLhXc0g=;
	b=BiffD4wmdAdf0LFutrBUyan+9uFhYru12+JZE0K8bi2EDjrBrLrKSMnkAdVUf0UkzN7mTa
	Wg2UhlRywqUwBY6rSLIha05JYG77kU7+g8OS1CoAO3MaJLu+7NQoAMojWCztO3xk4MHQxo
	r2VWOLgJIcohYsvafuETt8Qx6bDdSZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-GML84PdtPnCwkNzeZkzlTw-1; Thu, 28 Mar 2024 08:35:26 -0400
X-MC-Unique: GML84PdtPnCwkNzeZkzlTw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56865619070so480944a12.0
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2024 05:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629325; x=1712234125;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5ORqLKh8/XLA09MZvXXVlo+iCvFUPkDkTTQOLhXc0g=;
        b=Zsr/bDVO58rnwjmeX7as5PD1p4FwrEXHfMH431minhzT7ggR4qo5WfMXgfQsohxOv9
         7A1SaM59K8VUatJTjKObbVzSX4CFo9a+j3Ie5S21857BZvXRidz9b3g7iBpaRtfyfc97
         ka8PaXkefzDEThozBhLxcYTJd+tQe2ZJ69W9NIxqETO+DUqT0+5ckhDe484K6HkY05ho
         ntNod/uQ5Ta7iP1KTzMy15QSDdElfeYgJc8QuMZg7oLvBrbOV33DXifoQicR87iZd1WM
         5joChMxXQ15VolOrJM1GjMh8070zcQS/y9qX1FcvzAxm0Y4zFdSaOGcjOTI4rcdIl/Dt
         58RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyONl03hBdXM/ci1WTcsDH4uxNgVpa6fwgQpcYZY8cFqBQPmfchhxFU5DRBJSB07Mg/MKfroMHvL1ueAsM5I4aqj50A2DgaYAGpnKZ
X-Gm-Message-State: AOJu0YxlF2v8k9rNy1yR1R8eoIoIe8R1UpCukwjGc7HcCm+jVQO7Oqj6
	hbdBAI4twf4pNcf+JH4TWuNEri7hgxA4dqJy76VGqWGWamjh1h/yCE1QJ+IrCwWy+TIzgFvppGJ
	C9QcYtK8YGvBf59Itl9vsiG0wSAz951+6jUamy8hKIVXsoGnJcC+IzMRpgwNtVA==
X-Received: by 2002:a50:d714:0:b0:56b:7f43:5a57 with SMTP id t20-20020a50d714000000b0056b7f435a57mr2076132edi.15.1711629325340;
        Thu, 28 Mar 2024 05:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFooB4Zt8/8qHxcmDN4v9ebCm33206sgn4YrQJS/Io9J57x9QQacIHnpsXrzjZtCuYBg5j0Bg==
X-Received: by 2002:a50:d714:0:b0:56b:7f43:5a57 with SMTP id t20-20020a50d714000000b0056b7f435a57mr2076119edi.15.1711629324905;
        Thu, 28 Mar 2024 05:35:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g28-20020a056402321c00b0056c1c2b851esm793288eda.0.2024.03.28.05.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 05:35:24 -0700 (PDT)
Message-ID: <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
Date: Thu, 28 Mar 2024 13:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
From: Hans de Goede <hdegoede@redhat.com>
To: Peter Collingbourne <pcc@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 stable@vger.kernel.org
References: <20240317214123.34482-1-hdegoede@redhat.com>
 <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
 <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
In-Reply-To: <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/28/24 8:10 AM, Hans de Goede wrote:
> Hi,
> 
> On 3/18/24 7:52 PM, Peter Collingbourne wrote:
>> On Mon, Mar 18, 2024 at 3:36 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
>>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
>>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
>>>> Cherry Trail (CHT) SoCs.
>>>>
>>>> Before this change the RTL8732BS Bluetooth HCI which is found
>>>> connected over the dw UART on both BYT and CHT boards works properly:
>>>>
>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>>> Bluetooth: hci0: RTL: fw version 0x365d462e
>>>>
>>>> where as after this change probing it fails:
>>>>
>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>>> Bluetooth: hci0: command 0xfc20 tx timeout
>>>> Bluetooth: hci0: RTL: download fw command failed (-110)
>>>>
>>>> Revert the changes to fix this regression.
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>>> Note it is not entirely clear to me why this commit is causing
>>>> this issue. Maybe probe() needs to explicitly set the clk rate
>>>> which it just got (that feels like a clk driver issue) or maybe
>>>> the issue is that unless setup before hand by firmware /
>>>> the bootloader serial8250_update_uartclk() needs to be called
>>>> at least once to setup things ?  Note that probe() does not call
>>>> serial8250_update_uartclk(), this is only called from the
>>>> dw8250_clk_notifier_cb()
>>>>
>>>> This requires more debugging which is why I'm proposing
>>>> a straight revert to fix the regression ASAP and then this
>>>> can be investigated further.
>>>
>>> Yep. When I reviewed the original submission I was got puzzled with
>>> the CLK APIs. Now I might remember that ->set_rate() can't be called
>>> on prepared/enabled clocks and it's possible the same limitation
>>> is applied to ->round_rate().
>>>
>>> I also tried to find documentation about the requirements for those
>>> APIs, but failed (maybe was not pursuing enough, dunno). If you happen
>>> to know the one, can you point on it?
>>
>> To me it seems to be unlikely to be related to round_rate(). It seems
>> more likely that my patch causes us to never actually set the clock
>> rate (e.g. because uartclk was initialized to the intended clock rate
>> instead of the current actual clock rate).
> 
> I agree that the likely cause is that we never set the clk-rate. I'm not
> sure if the issue is us never actually calling clk_set_rate() or if
> the issue is that by never calling clk_set_rate() dw8250_clk_notifier_cb()
> never gets called and thus we never call serial8250_update_uartclk()
> 
>> It should be possible to
>> confirm by checking the behavior with my patch with `&& p->uartclk !=
>> rate` removed, which I would expect to unbreak Hans's scenario. If my
>> hypothesis is correct, the fix might involve querying the clock with
>> clk_get_rate() in the if instead of reading from uartclk.
> 
> Querying the clk with clk_get_rate() instead of reading it from
> uartclk will not help as uartclk gets initialized with clk_get_rate()
> in dw8250_probe(). So I believe that in my scenario clk_get_rate()
> already returns the desired rate causing us to never call clk_set_rate()
> at all which leaves 2 possible root causes for the regressions:
> 
> 1. The clk generator has non readable registers and the returned
> rate from clk_get_rate() is a default rate and the actual hw is
> programmed differently, iow we need to call clk_set_rate() at
> least once on this hw to ensure that the clk generator is prggrammed
> properly.
> 
> 2. The 8250 code is not working as it should because
> serial8250_update_uartclk() has never been called.

Ok, so it looks like this actually is an issue with how clk_round_rate()
works on this hw (atm, maybe the clk driver needs fixing).

I have added the following to debug this:

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3acbf0f5da1..3152872e50b2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -306,6 +306,8 @@ static void dw8250_clk_work_cb(struct work_struct *work)
 	if (rate <= 0)
 		return;
 
+	pr_info("uartclk work_cb clk_get_rate() returns: %ld\n", rate);
+
 	up = serial8250_get_port(d->data.line);
 
 	serial8250_update_uartclk(&up->port, rate);
@@ -353,11 +355,15 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 {
 	unsigned long newrate = tty_termios_baud_rate(termios) * 16;
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned long currentrate = clk_get_rate(d->clk);
 	long rate;
 	int ret;
 
+
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0 && p->uartclk != rate) {
+	pr_info("uartclk set_termios new: %ld new-rounded: %ld current %ld cached %d\n",
+		newrate, rate, currentrate, p->uartclk);
+	if (rate > 0) {
 		clk_disable_unprepare(d->clk);
 		/*
 		 * Note that any clock-notifer worker will block in
@@ -593,6 +599,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!p->uartclk)
 		return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
 
+	pr_info("uartclk initial cached %d\n", p->uartclk);
+
 	data->pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
 	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);

And then I get the following output:

[    3.119182] uartclk initial cached 44236800
[    3.139923] uartclk work_cb clk_get_rate() returns: 44236800
[    3.152469] uartclk initial cached 44236800
[    3.172165] uartclk work_cb clk_get_rate() returns: 44236800
[   34.128257] uartclk set_termios new: 153600 new-rounded: 44236800 current 44236800 cached 44236800
[   34.130039] uartclk work_cb clk_get_rate() returns: 153600
[   34.131975] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
[   34.132091] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
[   34.132140] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
[   34.132187] uartclk set_termios new: 1843200 new-rounded: 153600 current 153600 cached 153600
[   34.133536] uartclk work_cb clk_get_rate() returns: 1843200

Notice how the new-rounded just returns the current rate of the clk,
rather then a rounded value of new.

I'm not familiar enough with the clk framework to debug this further.

Peter, IMHO we really must revert your commit since it is completely
breaking UARTs on many different Intel boards. Can you please give your
ack for reverting this for now ?

Regards,

Hans


p.s.

For anyone who wants to dive into the clk_round_rate() issue deeper,
the code registering the involved clks is here:

drivers/acpi/acpi_lpss.c: register_device_clock()

And for the clocks in question fixed_clk_rate is 0 and both
the LPSS_CLK_GATE and LPSS_CLK_DIVIDER flags are set, so
for a single UART I get:

[root@fedora ~]# ls -d /sys/kernel/debug/clk/80860F0A:01*
/sys/kernel/debug/clk/80860F0A:01      /sys/kernel/debug/clk/80860F0A:01-update
/sys/kernel/debug/clk/80860F0A:01-div

With the 80860F0A:01-update clk being the clk which is
actually used / controlled by the 8250_dw.c code.

