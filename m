Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8C2DC765
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755941; cv=none; b=QFxcubJg2CllL0uhmxgslnL27QCBd1Dal0ymU3JNUs3ooqfqSJeYRYirBzF524CLfV+dZB3qB5pEDSyPdLq1TdrvFMRT0ekM9i/z/3GgDxXAR2ZIqv8X3paXc3dxoRsxkSjOBjlG67gczxiBnf5uh89AIjCN+FnmNQ/zSn6gNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755941; c=relaxed/simple;
	bh=RIWAVWSouF5cxgKV7AQM6tjB8N9y3liuhbcYrEu7Rn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYjk+91mJ9zBAHXAIRL+BKm6OCjT4NAIKFzUQOCK5K9R7IekdfbucSVIzQ9cbH8Tml8TyZLHC3qoHwPL9AYOloZmFCqy4JclL6M5DOzUZhWGC9qMgeUYEZ8qZzNrWA3W8DUPLxCiUbKBozYMB8Ou/Lmda6L0UyEh6BGgh6Hz0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dz0ZKdB8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCS21pf+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dz0ZKdB8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCS21pf+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873l3ea2820797
	for <linux-serial@vger.kernel.org>; Mon, 7 Sep 2026 04:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJAwezj9vhQOOF3sxVQNHSi5Nj/Hx7aYSLmPx3GVsTM=; b=Dz0ZKdB8M8ro8rS2
	h/78WWWbTT3rpq0olVaBmuXESE8Xz2KlecldXB1Z9IHfnU7WRrBlp5hJvc1s4CTO
	U5ESeED5EanhusMVJNVYv9PZGuQuqtwKdOdqoe2bFmnNwzH8EaeSOhPMsNap5hd+
	AzgwRNRGh7y4LZS43HENW/ppg+0IuRzZUjGY5RBc97wXa8sqPYS07x1Q0rlU4XcH
	TklXYp5dpFNfAikVEDjulSDKY4oD9+b7P8uphXINmJLxhvdXF+Gop2hP8lAJpf6R
	GrcGs13UCzprp4yV/sdyzvB3Akrn9VP5Cd6+EVQHaezbu6f9bhGjVE7IFCc8pe0X
	GEmFRQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggadhn1fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 07 Sep 2026 04:38:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so56803185ad.2
        for <linux-serial@vger.kernel.org>; Sun, 06 Sep 2026 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788755938; x=1789360738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJAwezj9vhQOOF3sxVQNHSi5Nj/Hx7aYSLmPx3GVsTM=;
        b=iCS21pf+UOEDMzCBb1QpYF/WGPd1IBcDEABUVGQeV7XhTSDlaxrmOE7JC3hAy3Xoy4
         qri8FJczTwdJE8q+/z/uNyRdHxhXTNRl0wiuzQW52zflT6SOQ/1pvkRf/PR13VEKvhin
         gFZiJzQYfPQaN8f5rWXM+O3QxMvuVc+702xoyuBVUfQjqIrq8fGFyvANETrT7D0gQyxf
         MtbuIxYVKmw6v8GfN+mnyzl2XOJjxJR6mHp/HMUaVW+luwIREVrynJ1U70W8rp6QINOk
         pJaOTX4GG/C/poqzRhD8mmZg3L2vlFY9ANSPB3hsux15UK3vN5LibSwX2pdRUrV8sYpk
         XzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755938; x=1789360738;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJAwezj9vhQOOF3sxVQNHSi5Nj/Hx7aYSLmPx3GVsTM=;
        b=QYbn/yqcrnze+EQNSG/xd0+1A9+daM5KNLyyNOSljWEPRQ0Xu/957AgJO+xkwIkBSn
         8JHgL53Kqjmc8+cOmHZHiijJWoH8NJWTZHLq1QFd+IWpUwQJ1U97GDz6V5evOcxyHRx6
         ph9upq+rCR/vqmq0e2e+B4f3pjPr1Q5YENWKujXJlDSGOu3nsUNZ+jr2OrZ6aSw4JHLP
         eStjK9h01CoyToNpXKMq0s7rZIpzJYW5l1FRdYxIZcUeOqlgxinkg6aigI0aDVYPeIVK
         awFG+mGGn6db0cZ8mxMaeTOKFiOhSW1ISpbRxWp0jQgRVHjhIen+aa9Avqynxthk0/vO
         DsJw==
X-Gm-Message-State: AFuF++lvYWwGTxrdKDZFU9W1Ctrwb+pLngv2ML0LwpF9Yr04o3EUVPaY
	DJM16cY5AIAoJMsugA+IaCev0TGdr5CTJemXR5vSVTg73tG/rmF8uUKL0Yga6qfSDWWGHnjWLeT
	l6JknjcLrIZVrIPJkzxzE71uJ7GsXQ7yC1wZ2PlMAKu14e4B283umfp7ayeiKTVibkPY=
X-Gm-Gg: AYBFou2AHSEP/Hhf4iXyaU9DamqBDreftNUczHvGfHQNbIshdKEWc4SPMAhk4J+Xz/g
	anPfQ3yiHd8wqGis3vs4MGzZ5LXnaTpJrThAqRLlEXJ8y6tZT7pYs0HW3n36M9s3PQ0qwimbIFh
	u3Kg198trggJgSqo3QGYFZAeMKQZCF+6jN7X3gl8DoGXgOFIll9kpDrdx1r+KBWcV+g09dzsgyn
	t0n78aAfKdRsPVkfj8M3homfZPFbggaFdlDk2SupBzlXhhUzvGoqyWfiMxQgbo4d+4ajOiGIz4u
	6CDED2lLoxztx8la36x3siSlFwhjv6EZGfCPNCq5yORAjoYBMSunxDh/hrne/JcKdTUI/sEGtUA
	7L4ulrV6wLKT7eNLt6WqsOUvahQw880KoDQ==
X-Received: by 2002:a17:902:6ac3:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2db127cde0fmr237123305ad.12.1788755937953;
        Sun, 06 Sep 2026 21:38:57 -0700 (PDT)
X-Received: by 2002:a17:902:6ac3:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2db127cde0fmr237122885ad.12.1788755937437;
        Sun, 06 Sep 2026 21:38:57 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm23807549eec.9.2026.09.06.21.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 21:38:56 -0700 (PDT)
Message-ID: <f6c2f6e8-36cb-40be-938a-a375ed8de620@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:08:53 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: serial: qcom_geni: don't ida_free() the console
 port line
To: sashiko-reviews@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v3-1-541757ec8a95@linaro.org>
 <20260904154409.7AC181F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <20260904154409.7AC181F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4oFnijJeHKiNt0XFeYlpmmiYD12vOF-q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA0NiBTYWx0ZWRfX3iU49q6Ec09b
 gz+HeW/DrRPb9cByt8yKu10VnEiRkHFS9wOb5QAiTeyI7r/4Lk0SrgNuepB1M5HVYdPMxaBFP+3
 xIjQhM6rWqGxcSJqAt4ZB8n2oztTZGdHU4DeKayymAnvvsTK1U0GPn6Ao9fu4xamYsPaie6rEia
 kNhplrTzuNZJNaPR0yhVfSwsWJE9yOfmc6H27ClJZbTeX7pw8JvklnKc2mcYnj1b6VJl142r1vt
 OcCRRyg5Cdu1XL7K933poKqu8O7vj08CbrrIzfdldPTvldHEsTIxNzdwKazVZ/t/iFkjmMPCwNd
 W4g9ELa/h88hvfNjnF4CB8vG4Jpl8CEgrwlTYxzeMotCngE5iEYV0YaX9sd3d9KXE3NDJnlxmTc
 9UhvQyzmxFREMz2UirbX8c6vZSAVlJGaiJmlvb9GHleBJ0T5gruV0/JDCDQo7xL0y+TPRrYINvY
 RL7SdjGOzQN8pnlacCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA0NiBTYWx0ZWRfX+fDzF0PIpnrb
 Y3H9gELi47QvG5obpoLSNwNMZDxFkhS97oLm/r1eY6p/j14XTIXF8dsTCCaXRmToOf9aN6CTZaA
 Y8wN8umfJevxhw8WxxMdGauPLpaQQPQ=
X-Authority-Analysis: v=2.4 cv=OceoyBTY c=1 sm=1 tr=0 ts=6a9e3fe3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=tkl45AEGKGAVdJQqdmAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4oFnijJeHKiNt0XFeYlpmmiYD12vOF-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070046

Hi Neil,
This appears to be already fixed by:

commit ("serial: qcom-geni: Fix port_ida handling for console and probe 
errors")

which also fixes additional port_ida leak paths.

On 9/4/2026 9:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] UART line IDA is permanently leaked on error paths in get_port_from_line() and early qcom_geni_serial_probe().
> - [High] Dedicated wake IRQ and device wakeup capabilities are leaked if probe fails late.
> - [High] Manual call to `dev_pm_domain_detach_list()` causes a double-free because the list is managed by devres.
> - [High] The static console port permanently fails probing if a transient error occurs during `probe()`.
> - [High] The probe error path blindly unmaps the RX DMA buffer, even if the mapping failed.
> - [Medium] Premature `ida_free()` in `qcom_geni_serial_remove()` creates a race condition for the line ID.
> --
> 
> commit 8e6b3b4c6a06ece45749a076a423f5ca442974fa
> Author: Neil Armstrong <neil.armstrong@linaro.org>
> 
> tty: serial: qcom_geni: don't ida_free() the console port line
> 
> The console port is a static instance whose line is hardcoded to 0 and is
> never allocated from port_ida. This patch fixes qcom_geni_serial_remove()
> and the matching probe() error path so unbinding the console device doesn't
> hit a warning.
> 
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 3633723acef8d..1a36e9fad9768 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   						port->wakeup_irq);
>>   		if (ret) {
>>   			device_init_wakeup(&pdev->dev, false);
>> -			ida_free(&port_ida, uport->line);
>> +			if (!data->console)
>> +				ida_free(&port_ida, uport->line);
>>   			goto error;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does qcom_geni_serial_probe()
> leak the UART line IDA on other error paths?
> 
> If deferred probing causes qcom_geni_serial_probe() to repeatedly fail, the
> IDA leaks multiple times and can exhaust the IDA range, permanently breaking
> device initialization.
> 
> In get_port_from_line(), an IDA is dynamically allocated via
> ida_alloc_range(). If the subsequent devm_kzalloc() fails:
> 
> 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> 	if (!port)
> 		return ERR_PTR(-ENOMEM);
> 
> the function returns directly without freeing the IDA.
> 
> Similarly, in qcom_geni_serial_probe(), early failures like resources_init()
> or late failures jumping to the shared error: label fail to call ida_free()
> for non-console ports. The patch fixes one specific path but leaves the rest
> leaking.
> 
> [Severity: High]
> This is a pre-existing issue, but is the shared error cleanup path missing a
> rollback of the wake IRQ or wakeup capabilities?
> 
> If dev_pm_set_dedicated_wake_irq() succeeds, the wake IRQ is registered on
> the device. If a subsequent initialization step fails (e.g.,
> pm_runtime_resume_and_get()), the code jumps to the error: label:
> 
> error:
> 	if (port->rx_dma_addr) {
> ...
> 
> The error: block entirely fails to call dev_pm_clear_wake_irq() and
> device_init_wakeup(&pdev->dev, false), leaving a dangling interrupt handler
> registered to a failing device. This can cause spurious interrupts, crashes,
> or panics when triggered after the device memory is freed.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but will the error path blindly
> unmap the RX DMA buffer, even if the mapping failed?
> 
> In qcom_geni_serial_probe(), dma_map_single() returns an error token when
> mapping fails, which is non-zero (typically ~0ULL):
> 
> 		if (dma_mapping_error(pdev->dev.parent, port->rx_dma_addr)) {
> 			ret = -EIO;
> 			dev_err(&pdev->dev, "Failed to map RX DMA buffer: %d\n", ret);
> 			goto error;
> 		}
> 
> The error: block checks if (port->rx_dma_addr), which evaluates to true for
> the non-zero error token, and erroneously calls dma_unmap_single() on the
> error token:
> 
> error:
> 	if (port->rx_dma_addr) {
> 		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
> 				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
> 
> Calling dma_unmap_single() on an error token violates the DMA API and can
> cause kernel panics or IOMMU faults.
> 
> [Severity: High]
> This is a pre-existing issue, but can a transient error during probe()
> permanently break the static console port?
> 
> qcom_geni_serial_probe() checks if (uport->private_data) to prevent two
> drivers from claiming the same port, and subsequently assigns:
> 
> 	port->private_data.drv = drv;
> 	uport->private_data = &port->private_data;
> 
> If a later step in probe() fails, the function returns an error but does not
> clear uport->private_data. For the console, port points to the statically
> allocated qcom_geni_console_port. Thus, the non-NULL state persists.
> 
> When deferred probe retries, it hits the uport->private_data check and
> returns -ENODEV permanently, rendering the system without a working console.
> 
>>   		}
>>   	}
>> @@ -2015,6 +2016,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   static void qcom_geni_serial_remove(struct platform_device *pdev)
>>   {
>>   	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
>> +	const struct qcom_geni_device_data *data = port->dev_data;
>>   	struct uart_port *uport = &port->uport;
>>   	struct uart_driver *drv = port->private_data.drv;
>>   
>> @@ -2024,7 +2026,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
>>   	irq_work_sync(&port->tx_kick);
>>   	dev_pm_clear_wake_irq(&pdev->dev);
>>   	device_init_wakeup(&pdev->dev, false);
>> -	ida_free(&port_ida, uport->line);
>> +	if (!data->console)
>> +		ida_free(&port_ida, uport->line);
>>   	uart_remove_one_port(drv, &port->uport);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does calling ida_free() before
> uart_remove_one_port() create a race condition for the line ID?
> 
> ida_free(&port_ida, uport->line) marks the port's line ID as available
> immediately. A concurrent probe (e.g., via hotplug or deferred probe
> resolution) could allocate the freed line ID.
> 
> The concurrent probe would attempt to register a new port using the same ID
> while uart_remove_one_port() is still running for the old port, leading to a
> collision in the serial subsystem.
> 
> [Severity: High]
> This is a pre-existing issue, but does the manual call to
> dev_pm_domain_detach_list() here and in the probe error path cause a
> double-free?
> 
> For the sa8255p compatible device, resources_init() points to
> geni_se_domain_attach(), which calls devm_pm_domain_attach_list() to attach
> power domains. This registers a devres action to automatically free the list.
> 
> Both the error: path in qcom_geni_serial_probe() and
> qcom_geni_serial_remove() manually call:
> 
> 	dev_pm_domain_detach_list(port->se.pd_list);
> 
> dev_pm_domain_detach_list() calls kfree(list). When devres subsequently
> cleans up, it invokes devm_pm_domain_detach_list() on the exact same dangling
> pointer. This double-free on a list pointer leads to a Use-After-Free kernel
> panic, which can be triggered by probe failure or by unbinding the driver.
> 
>>   
>>   	if (port->rx_dma_addr) {
> 

