Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05820451999
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428360; cv=none; b=LblxD0qUGVbG3t4n/2hbXTztCx1TzPVEVsjSLrp4WPWPzIvSeE3weLYDpOWgSbzUB2e7oxgk4pJJg6/oeq4ydKa8MSQUHYad+WDajNyPCga4fGQGt0A1+39My4jDRa/VxWcgqbuWDXmbr84NcP3E+yWuNxzMTMn2k5VaQz85fKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428360; c=relaxed/simple;
	bh=wYyXYRqo+5m6fDSZrA7VcCiGU6fKVHm0kgX5xTnPxGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujt1mCSpSElBr00oetUzEh9uyiPNAn/Ib/XD9uXjtcpEuQxL4nqKLn3zvlJ/w39+5ZJMn7Km8/Ek9ny/96AeDc5LcX1HcAVqRZK0V4tjByHmtG3D0J3CI2DzLdlLqItW4HzOQCat7ct4iC2P1JaFfqD+jbbOfWO2/mL389cosbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=me/lWvC4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CStaQZZS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="me/lWvC4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CStaQZZS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQoh92401514
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cs2s79pOcvGj18JkogxK17ApOg6ZjNFEALIFF0mhsrk=; b=me/lWvC4cS2dSAZa
	q6cw/iggGzMi45EjSSLI9v5U5/FeqXSwMsxFlXPsFUNJN8x8HhPsvVMSQs/Lz4oo
	p/XF+M/AdOfhArexBdtDyduBx/mOOxoTy7mFgCmCirtQlRLAJRGxkDaOB13KlU1j
	dcqhY/uqegYDLL+WvfACQjfNwLZHw30hJkRAS6wNY6YNq3ZfdUZbzlFhTZjdFal+
	jvEBlL7CFEbB2pj0+x1BAOtiyXhiF2w2VGC4a+sENmQJPRCeKNavAjUPjvEp69Tj
	QeDKTNPzV6s7nxJIM7jfteRoyStCpZWInZAxMCUXNYjeV9KQDOgFZg8WaVqc1mYH
	RnxxVQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8168ryy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:19:18 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bfc08e95ebso5993e0c.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785428357; x=1786033157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cs2s79pOcvGj18JkogxK17ApOg6ZjNFEALIFF0mhsrk=;
        b=CStaQZZSN6VsuTbloChJZqTvpcrFedifTLYReNiLD+2v9T0kZgtBGhr4LEiCeGBjoy
         lExxOXFYCyeUILuDlGcQoMr3mfXYOeMdMTjzpB0OGI+AjylcaSNfedZw090mZBby6pIt
         zdT2ZZl12S0QAlxB81E8zSh4/qxyJnT2pjxsJ8eUggpbiOmvtI9Vl1ZZbaxyW8spP5eR
         /pnp9Eo/WlpLy7vSQiqoIUCbNsBKv3IYIwcdsKNeEDkj781HiSyBC1n/g498YKqHfTFX
         3p6Umbtw+BewTJTyGM79aLpnvve+0AEkS/d6oBOMxu0iE1bu5lrNjl3q6N+KXnhG5KLy
         8hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428357; x=1786033157;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cs2s79pOcvGj18JkogxK17ApOg6ZjNFEALIFF0mhsrk=;
        b=EcTIG0yseFNgxYAu6Qp1s6Wdzw5Usf6cwH4R0M097w/ie8jgRt4ULTlleRVcczE31r
         TEqtb31jx/LTiqKJDNgCRclPDoMJgvVjtxBskQcAUdqlVJSDxcP6DM2cZUi2zIre2aA2
         AzItG60Dgwcc3DHTQ0JDpVJI9RF0PgwKDo9P0IAcaHVNEu0/pSMnvSvKMm4VP3b9gK2M
         DG0H4ERHiQ4KQRenqTvX0Ls5CN5RyajIXI1r4jiAhzWul+OBPhF+a+dIpHSafcjboQ0F
         TdtDnguuc8Ur7WUM0qqgmNs9vzvzOl1nlwtONnV6JNBMiSWD+5tfPz3PRGf++HOGAkvf
         fMUg==
X-Forwarded-Encrypted: i=1; AHgh+RpW3i8LWglJCH8tXWJgvvXQcmRztJitxccCb3r8Q4/6TXIf4CvXrVKJE9K2AAMN6x17Lwg2HhBU36WpGlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eRNu8Vy35ACV6/NujD823/JNH+ETvk5dNUC5KqQfPpwCJnem
	A7Id2pxcnaflV0365btL8YhnhtIfeWyvxFpIZR5eAewNKtWlAQhOyu4E4+5Zq2SWBCsX9oHAgk/
	dmYw99hw3CtOoMrIOkOj62/VVPQhIOM76Q1QlVhxOHnknMVapV9ueF87hwxbSEYg2ZJw=
X-Gm-Gg: AR+sD139Z+A79N57+AWMtp3QtxIcQQBHry7FlMinNZAPgN9CnropIq1jqtbYNT1JSzt
	r0nbQ95Elu2LRxurGYbhzjC66fQnKjA+rAXzAtFIkJqKH2Uk2mXt2IUX7lPeRTp/DD+lng43w8i
	SFyxio2BFPw6cYNM8uNkUGSVOzKlrwM7fnVY7sYkr4NgSMKtBSn15mxq7Nlbes5WoHk7muyDRw2
	Dmt4UNOcDAQ8pYA3ggeQ3uidYteg4+oZamP3TCP2y4VVIU595B/x7tDKrbW59NYjz5X9mxTXRij
	1IMPYHGwOPMMMCvQ8aZZOuAmOVri4yKSfjUVHFdPBx2oSDMfIuh8jYjPUYUL/vMeAPEtpvf+G26
	4MLXocbn20joqkktaQK0uyGcd
X-Received: by 2002:a05:6102:3585:b0:74a:b1ee:e21b with SMTP id ada2fe7eead31-7583f18ec20mr587443137.1.1785428357039;
        Thu, 30 Jul 2026 09:19:17 -0700 (PDT)
X-Received: by 2002:a05:6102:3585:b0:74a:b1ee:e21b with SMTP id ada2fe7eead31-7583f18ec20mr587435137.1.1785428356560;
        Thu, 30 Jul 2026 09:19:16 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db9baa18sm467105e87.48.2026.07.30.09.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:19:15 -0700 (PDT)
Message-ID: <ef2a2f3a-1051-4527-8e13-0af263a443ba@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:19:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: qcom-geni: Convert console to nbcon
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260729-qcom-geni-nbcon-v1-0-3053b96465ed@oss.qualcomm.com>
 <20260729-qcom-geni-nbcon-v1-1-3053b96465ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260729-qcom-geni-nbcon-v1-1-3053b96465ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX4a/nTCxNoQQs
 4Aq/c8APLA6lsO5HK73oQAnB769laPv4n005fR1QZbRmEgweCjGv1X8Xqax/663a2o5VvgY7K+2
 Qkyy+AiSJ83v/IKteKf2x0hXHvZ7zG1vZrCWf/lEiOo/yPUPdpjodsiE5GS+h3HDib6BzP33HUo
 9RtiCyshm3VjqoBvy8NngwASE3mw4A9awH2rQfCs0oNFs4Q2uW5srDgGfJaNEMUpmCLK/6lXqre
 1F9XzSbPDOUEPWwDtQqvFJBsTWMQxmZIS4GxvsInRbQ+bHcSPR0hEx7IXhBt38x9s+fCQzhjalN
 fjq/LeJOAWtRqzdxyQHnzfTc5CLaB8BQTeV7Ye41H0n4bN31KZymdjvO3Z8n8SHLLgQmZQ6JuQX
 H8rsHqTII4me45PdThRigv9Dq/7rLevU65smxhBrX5BJgHnNrglkX8sXCNjxYsvFvvmcUQuPBBE
 t0Las+DWgVsfdN8c7UQ==
X-Authority-Analysis: v=2.4 cv=LIlWhpW9 c=1 sm=1 tr=0 ts=6a6b7986 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fnIB__cAoprSpsgZYR4A:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: WyOXcDNZUZEDsLYVZBqmow9r-rwPZyZY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXztLZKVrcyLxh
 WcV2ngbGmWfgh0bMErbT0KDBkb03CCL2MFuQPv6pdRNCUZ4lM1YeXNCdkr8MT+9yXkfcyIuyicH
 kws6HVNuQyySznNv1KgmSwCKFV6rnck=
X-Proofpoint-GUID: WyOXcDNZUZEDsLYVZBqmow9r-rwPZyZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

On 7/29/26 11:44 PM, Bjorn Andersson wrote:
> The legacy GENI console writer serializes every message around a
> synchronous polled M-side transfer. It blocks printk callers for UART
> wire time and cannot provide atomic output while normal console output is
> active.
> 
> Convert the console to nbcon threaded and atomic writers. Use the UART
> port lock as the device lock and bound threaded M-side commands so
> urgent diagnostics can take over atomic output. The threaded writer is
> batching the output in 32-source-byte commands, a value chosen to
> balance the command setup overhead with atomic-handoff latency.
> 
> Atomic output can cancel an active normal TX command. Use irq_work to
> resume queued TTY output afterward, honor flow control, and prevent the
> deferred restart from accessing the port during shutdown or removal.
> 
> Assisted-by: OpenCode:GPT-5.5
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

[...]

> +	while (offset < wctxt->len) {

Other nbcon drivers access wctxt->len in write_thread with READ_ONCE,
I believe we need to do the same

[...]

> +static void qcom_geni_serial_console_write_atomic(struct console *co,
> +						  struct nbcon_write_context *wctxt)
> +{
>  	struct qcom_geni_serial_port *port;
> +	struct uart_port *uport;
>  	u32 m_irq_en, s_irq_en;
> -	bool locked = true;
> -	unsigned long flags;
> -
> -	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);

Unrelated?

[...]

> +/* Caller holds the UART port lock. */
> +static void qcom_geni_serial_resume_tx(struct uart_port *uport)
> +{
> +	if (!uart_tx_stopped(uport) &&
> +	    !kfifo_is_empty(&uport->state->port.xmit_fifo))
> +		qcom_geni_serial_start_tx_fifo(uport);
> +}

This is a single-use oneliner, but perhaps having 3+2 conditions
is better than having 5 conditions to an if statement..


> +
> +static void qcom_geni_serial_restart_tx(struct irq_work *work)
> +{
> +	struct qcom_geni_serial_port *port = container_of(work,
> +						      struct qcom_geni_serial_port, tx_kick);
> +	struct uart_port *uport = &port->uport;
> +
> +	if (!READ_ONCE(port->tx_kick_enabled) || !uport->state || uport->suspended)
> +		return;
> +
> +	uart_port_lock(uport);
> +	if (READ_ONCE(port->tx_kick_enabled) && uport->state && !uport->suspended)
> +		qcom_geni_serial_resume_tx(uport);
> +	uart_port_unlock(uport);
> +}
> +
>  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
> @@ -1182,6 +1284,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>  
>  static void qcom_geni_serial_shutdown(struct uart_port *uport)
>  {
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +
> +	/* Atomic console output queues tx_kick without taking the port lock. */

non-atomic?

Konrad
