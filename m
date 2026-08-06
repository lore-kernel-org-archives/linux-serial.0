Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45425202F71
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022965; cv=none; b=pAfg+h3EAFMcoira8YmannBxbM3SO1crjiiQD4BCNTdCpWY/0uwOXKsrjvmGTxOBvz/cR34YMy5NsejKZ5w7Mq6mIrePySlnbOQKqd06iMdV2VGNfSeG24ZGUhTnvOzRbn6ILRtF7dBQTnrqXqsZbj6U2A9nC2EPjbcpKNSspP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022965; c=relaxed/simple;
	bh=8YS8emQ2hkbQSYoQux4TSG1xkCxZsjykW02xJolOQRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKrr4r3tE0jBbRKIBdJzgktEfUEaIr5b2Vpmn1tkD61JLMPNn8pncGg+ELCHSyKtvH8pa2dnZRUO20F6XFxeWwaD4U3HUSF6bwFe3yy4npmGMWzn8RujXB288YttchMMQisMpcPZlLWA6DFuHUjGS8hvTfwtubFBFMnVUqLXo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4+XzvY8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvmCvRzW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4+XzvY8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvmCvRzW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676BwoQA3037266
	for <linux-serial@vger.kernel.org>; Thu, 6 Aug 2026 13:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mxzz+WTOgBBlFJhkUvPwCDBHC2YRBQowFgDJEHp87L4=; b=m4+XzvY8KZjHbMQu
	4S45rUlSfDnCfQwJrkUo/1hxY0QOmKAwqGBjC6hic8C+1PVy88K0WUTBoMMsY0pp
	Ibll+CMdl2a2vxGYCUhi6QNhe/UMNWEahA7eauYgiyDZkuja3P+qkff4hSi8NWu0
	cYU5hwE8qkm7T8FDqA9+Eic3trU8t6suv6unw3I3u8n9rdDInSe5CkFVa7GhvRij
	ww+TdFTxLuuVu/U6dfE/gWfHyJEyIbtz59BqUkiDXPX0Vk+lvu3j5OJS7eUpoIkc
	Emqp9uotU0GZTF2aAHgNorg8qNdLFfgnbuNZp7wB1HDNGikl6bZgsWkedkM6UrKW
	4oj3Nw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvsvd0e46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 13:29:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso3771405a12.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786022961; x=1786627761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mxzz+WTOgBBlFJhkUvPwCDBHC2YRBQowFgDJEHp87L4=;
        b=dvmCvRzW2TLlmVMLs3Xw3RN0Iomo1K3C0IC5HfO/FKs7GlXMSnH6/wM5AHiwNzoAhR
         coOITC/8ckkJQ2o1ww0qop9alCXrRjc/4JbHEgtDG/Aev8xksj7dXRMd4BOy+VlNSP1z
         eApu8UH1jzAdzz/Saqo3hXcbJies9Y7ecSeTymOw5KrtB9MCyF1p/6w+2zvcPAEvw4rN
         p78JH6dTV66ydccPa15Vi+mnQ6IlpeHH8f5k5s9uDpkbtLCD0yZv3HKv81sy3BbNVTbz
         f1FgcHqX4Z2hKQRBkYZ0uitbioPBe8UA+V0ubbfz6CuKVwCH/WLS6r1k/ktoryL6C0ag
         U0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022961; x=1786627761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxzz+WTOgBBlFJhkUvPwCDBHC2YRBQowFgDJEHp87L4=;
        b=frWt7rjJ62Q/HGek/FN7si3a//7fc1VIqnrNo43cxAaIDvVVaS6IkbEsdi4JVhBDrP
         6qgjJT+8MYAoWocp2FAOL9PTd0EOCBWEv6alAPPkQbYU9nzKA1vshUuAD8wRimUw0qGs
         y63fOXJKYm2dhNK+H4L4ELPc5Tsby+a9pAA1Vr07ylxtqojG+Vybe9uKA1j5HAZ/Ag7R
         JDTlJJEe8d2nhhOy2kUcA1xY5EB0we52rp2pKVrOVcyNOau4UcYF5kkwypIo5b8mXy2w
         YkihtOtdDvOHOF8GKRLbUIgKh5ZcaE7OPgdufzeuoV/yPO3CciVnHt8cnmCrnJPlouKj
         KF2g==
X-Forwarded-Encrypted: i=1; AHgh+RrDS6oIgt0Gzcug9X/kZu/HbRTblIVW46UmPjrBjl8F0JAruuvUO9ymbmywB20QAqjSi+267k3HGSnx7Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzehpx7t60Xvc2lKg0veoEo9JUBaHNcpDXeEfP8UYF+KSK576
	SW+wMG2eg29ZPKrL85Rp589ph3I0rY7ndzEkf60okvtsJ2P9I5qr+d0v8qQqWJoiGrCsJ+oxKF7
	l1K/Z+Ue+hSsQg92jCcCECBVApAbrIIaUOU5JPhwBc7MOPJrYCGRUEeB4wPsA/E8UiQaw8zC8xy
	o=
X-Gm-Gg: AR+sD11x258lH8zjZc33SEtrfgnFdxRNNJmQURXNdB2bE84afZmZwnZzPMYwozjIUiK
	VZnGxnPZpoRik+5LtEDPPh2qBa/fYPfNTE4GeXvshcrdLv5xmslSTr0Nq4udMwo28QK8KysDdqr
	QfyN+DebofpFiyfuuRGmLkYbMhhvVloFmrz6khquOA1A1gM+jDSA7wLyLUTOL0y1czvVaWHdEKZ
	hw1NUp5fof0DgNCAulsWLPzmPMwWTk+FdWmWiS34wfgZGQfd4DWhtbZelzZ8fjcWlavbB4brEW5
	XHQr7rI+MVMnZKln/9LBWqmt39BV5JLph07bSOH2OpjzMTY8vIXKPTn6CHOAooCJDLCfXG7zj8I
	rYH5uNqvfZuI71/tMnKtyqSX8KTZzZeENwg==
X-Received: by 2002:a05:6a20:4391:b0:3c0:b4f8:bbfb with SMTP id adf61e73a8af0-3cb85e5cb78mr18636782637.22.1786022961071;
        Thu, 06 Aug 2026 06:29:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:4391:b0:3c0:b4f8:bbfb with SMTP id adf61e73a8af0-3cb85e5cb78mr18636694637.22.1786022960392;
        Thu, 06 Aug 2026 06:29:20 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1fd4sm6385858eec.14.2026.08.06.06.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:29:19 -0700 (PDT)
Message-ID: <a7536bd0-a3a5-43e6-ab70-681d504b4c5e@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 18:59:15 +0530
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
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <20260729-qcom-geni-nbcon-v1-1-3053b96465ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNiBTYWx0ZWRfX7HwjsIrsNpAd
 AQgMCZtyIfjCfsc8STioL4da2rhE3m5SlfcTPCZ52zIAxJ1Qy/aOhNLUEx1XCmZgRQ+atgi3DaW
 MfuJG4IfdxDhkTYY/ZdK4lKhMDrltk0=
X-Authority-Analysis: v=2.4 cv=WbY8rUhX c=1 sm=1 tr=0 ts=6a748c31 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IJ2DtnMTExtOd4LojYMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: iMc6CltG-ogLl95GY5zxAB_mnWyqkS-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNiBTYWx0ZWRfX/OyfYb9kC21g
 Nt38QZxZ7FWCc9GT96GRDtgYt5jCgfCyDIM0NZJ42TW7Kt1qHD5KFsELqqQ4xVR2Z3SzEQPDqbU
 9knAGuvNLShQ38SwTuFAtYixwAb426LXwXvNQk7+Y1C/KFliZn/wxKY78guv4ogrQBEH6+10WUL
 BRi1K54pCW2UiTezE3deh1AaKH8hEKi+X2tYTbaNAOBVWGbq733o+LQBhF7bGwD+krsX9FzZpq1
 JXjXGQZB5Tb/ByR/XcJkoox5dcX70eV9rss8AeRRam7hfCyA1m99nqR+NGEgfkUIMyDcoJ6F1Ki
 ZxQ5QVAXG664m/2yRRCF94xTNAM4n9EJh198AQm2zp6931/8lT2D+RnkVjREsTqXwgSbNEYdWLA
 1UPSaXUZmjrX0GsLbJUlfLAd0O8M/qaLxNNbveK8bQD8bs8lefr3xX923Pumu1Zi/a7/bUaxZLD
 OSc16az0jrzcGEaijqA==
X-Proofpoint-GUID: iMc6CltG-ogLl95GY5zxAB_mnWyqkS-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060106



On 7/30/2026 3:14 AM, Bjorn Andersson wrote:
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
>   drivers/tty/serial/qcom_geni_serial.c | 166 ++++++++++++++++++++++++++++------
>   1 file changed, 140 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 67b14fda4ff9..08427390c173 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -16,6 +16,7 @@
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/irq.h>
> +#include <linux/irq_work.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/panic_notifier.h>
> @@ -89,6 +90,7 @@
>   #define DEF_TX_WM			2
>   #define DEF_FIFO_WIDTH_BITS		32
>   #define UART_RX_WM			2
> +#define CONSOLE_TX_CHUNK_SIZE		32

I noticed that CONSOLE_TX_CHUNK_SIZE is limited to 32 bytes, effectively 
using only half of the 16-word TX FIFO. Was 64 bytes tested and found 
problematic, or is 32 bytes simply a conservative default?

>   
>   /* SE_UART_LOOPBACK_CFG */
>   #define RX_TX_SORTED			BIT(0)
> @@ -153,7 +155,8 @@ struct qcom_geni_serial_port {
>   	bool rx_tx_swap;
>   	bool cts_rts_swap;
>   	bool manual_flow;
> -
> +	bool tx_kick_enabled;
> +	struct irq_work tx_kick;
>   	struct qcom_geni_private_data private_data;
>   	const struct qcom_geni_device_data *dev_data;
>   	struct dev_pm_domain_list *pd_list;
> @@ -168,6 +171,8 @@ static struct uart_driver qcom_geni_uart_driver;
>   static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>   static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>   static int qcom_geni_serial_port_setup(struct uart_port *uport);
> +static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport);
> +static void qcom_geni_serial_resume_tx(struct uart_port *uport);
>   
>   static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
>   {
> @@ -539,49 +544,123 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>   	qcom_geni_serial_poll_tx_done(uport);
>   }
>   
> -static void qcom_geni_serial_console_write(struct console *co, const char *s,
> -			      unsigned int count)
> +static void qcom_geni_serial_console_takeover(struct uart_port *uport,
> +					       bool preserve_tx)
> +{
> +	if (qcom_geni_serial_main_active(uport)) {
> +		struct qcom_geni_serial_port *port = to_dev_port(uport);
> +
> +		if (preserve_tx) {
> +			if (port->tx_remaining == 0)
> +				qcom_geni_serial_poll_tx_done(uport);
> +			else
> +				qcom_geni_serial_drain_fifo(uport);
> +		}
> +
> +		qcom_geni_serial_cancel_tx_cmd(uport);
> +	}
> +}
> +
> +static void qcom_geni_serial_console_write_thread(struct console *co,
> +						  struct nbcon_write_context *wctxt)
>   {
> +	struct qcom_geni_serial_port *port;
>   	struct uart_port *uport;
> +	unsigned int offset = 0;
> +
> +	port = get_port_from_line(co->index, true, NULL);
> +	if (IS_ERR(port))
> +		return;
> +
> +	uport = &port->uport;
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	qcom_geni_serial_console_takeover(uport, true);
> +	if (!nbcon_exit_unsafe(wctxt))
> +		return;

When nbcon_enter_unsafe()/exit_unsafe() report lost ownership, 
write_thread() returns after console_takeover() has cancelled the
active M command, skipping resume_tx(). As far as I can tell TX still
recovers: M_IRQ_EN and TX_WATERMARK_REG are untouched, so the latched
watermark re-asserts on the drained FIFO and the ISR reaches
handle_tx_fifo() with active=false, which re-issues setup_tx() for the 
remaining xmit_fifo data.

Is that the intended fallback? A comment would help, since it is an
implicit dependency on the !active recovery path rather than anything
local to write_thread().

Thanks,
Aniket

> +
> +	while (offset < wctxt->len) {
> +		/*
> +		 * Printk records can be much larger than the FIFO. Limit one
> +		 * M-side command to 32 source bytes so atomic console output can
> +		 * take over between commands instead of waiting for the record.
> +		 */
> +		unsigned int count = min_t(unsigned int, wctxt->len - offset,
> +						   CONSOLE_TX_CHUNK_SIZE);
> +
> +		if (!nbcon_enter_unsafe(wctxt))
> +			return;
> +
> +		__qcom_geni_serial_console_write(uport, wctxt->outbuf + offset,
> +						 count);
> +		offset += count;
> +
> +		if (!nbcon_exit_unsafe(wctxt))
> +			return;
> +	}
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	qcom_geni_serial_resume_tx(uport);
> +	nbcon_exit_unsafe(wctxt);
> +}
> +
> +static void qcom_geni_serial_console_write_atomic(struct console *co,
> +						  struct nbcon_write_context *wctxt)
> +{
>   	struct qcom_geni_serial_port *port;
> +	struct uart_port *uport;
>   	u32 m_irq_en, s_irq_en;
> -	bool locked = true;
> -	unsigned long flags;
> -
> -	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
>   
>   	port = get_port_from_line(co->index, true, NULL);
>   	if (IS_ERR(port))
>   		return;
>   
>   	uport = &port->uport;
> -	if (oops_in_progress)
> -		locked = uart_port_trylock_irqsave(uport, &flags);
> -	else
> -		uart_port_lock_irqsave(uport, &flags);
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
>   
>   	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>   	s_irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
>   	writel(0, uport->membase + SE_GENI_M_IRQ_EN);
>   	writel(0, uport->membase + SE_GENI_S_IRQ_EN);
>   
> -	if (qcom_geni_serial_main_active(uport)) {
> -		/* Wait for completion or drain FIFO */
> -		if (!locked || port->tx_remaining == 0)
> -			qcom_geni_serial_poll_tx_done(uport);
> -		else
> -			qcom_geni_serial_drain_fifo(uport);
> -
> -		qcom_geni_serial_cancel_tx_cmd(uport);
> -	}
> -
> -	__qcom_geni_serial_console_write(uport, s, count);
> +	qcom_geni_serial_console_takeover(uport, false);
> +	__qcom_geni_serial_console_write(uport, wctxt->outbuf, wctxt->len);
>   
>   	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   	writel(s_irq_en, uport->membase + SE_GENI_S_IRQ_EN);
> +	nbcon_exit_unsafe(wctxt);
>   
> -	if (locked)
> -		uart_port_unlock_irqrestore(uport, flags);
> +	/* Restart TTY data left queued when atomic output canceled M TX. */
> +	if (READ_ONCE(port->tx_kick_enabled))
> +		irq_work_queue(&port->tx_kick);
> +}
> +
> +static void qcom_geni_serial_console_device_lock(struct console *co,
> +						  unsigned long *flags)
> +{
> +	struct qcom_geni_serial_port *port;
> +
> +	port = get_port_from_line(co->index, true, NULL);
> +	if (IS_ERR(port))
> +		return;
> +
> +	__uart_port_lock_irqsave(&port->uport, flags);
> +}
> +
> +static void qcom_geni_serial_console_device_unlock(struct console *co,
> +						    unsigned long flags)
> +{
> +	struct qcom_geni_serial_port *port;
> +
> +	port = get_port_from_line(co->index, true, NULL);
> +	if (IS_ERR(port))
> +		return;
> +
> +	__uart_port_unlock_irqrestore(&port->uport, flags);
>   }
>   
>   static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> @@ -738,6 +817,29 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
>   	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
>   }
>   
> +/* Caller holds the UART port lock. */
> +static void qcom_geni_serial_resume_tx(struct uart_port *uport)
> +{
> +	if (!uart_tx_stopped(uport) &&
> +	    !kfifo_is_empty(&uport->state->port.xmit_fifo))
> +		qcom_geni_serial_start_tx_fifo(uport);
> +}
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
>   static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>   {
>   	u32 irq_en;
> @@ -1182,6 +1284,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>   
>   static void qcom_geni_serial_shutdown(struct uart_port *uport)
>   {
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +
> +	/* Atomic console output queues tx_kick without taking the port lock. */
> +	WRITE_ONCE(port->tx_kick_enabled, false);
> +	irq_work_sync(&port->tx_kick);
>   	disable_irq(uport->irq);
>   
>   	uart_port_lock_irq(uport);
> @@ -1281,6 +1388,7 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>   	uart_port_unlock_irq(uport);
>   
>   	enable_irq(uport->irq);
> +	WRITE_ONCE(port->tx_kick_enabled, true);
>   
>   	return 0;
>   }
> @@ -1627,10 +1735,13 @@ static void console_unregister(struct uart_driver *drv)
>   
>   static struct console cons_ops = {
>   	.name = "ttyMSM",
> -	.write = qcom_geni_serial_console_write,
> +	.write_atomic = qcom_geni_serial_console_write_atomic,
> +	.write_thread = qcom_geni_serial_console_write_thread,
> +	.device_lock = qcom_geni_serial_console_device_lock,
> +	.device_unlock = qcom_geni_serial_console_device_unlock,
>   	.device = uart_console_device,
>   	.setup = qcom_geni_console_setup,
> -	.flags = CON_PRINTBUFFER,
> +	.flags = CON_PRINTBUFFER | CON_NBCON,
>   	.index = -1,
>   	.data = &qcom_geni_console_driver,
>   };
> @@ -1946,6 +2057,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   
>   	port->private_data.drv = drv;
>   	uport->private_data = &port->private_data;
> +	init_irq_work(&port->tx_kick, qcom_geni_serial_restart_tx);
>   	platform_set_drvdata(pdev, port);
>   
>   	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> @@ -2000,6 +2112,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
>   
>   	atomic_notifier_chain_unregister(&panic_notifier_list, &port->panic_nb);
>   
> +	WRITE_ONCE(port->tx_kick_enabled, false);
> +	irq_work_sync(&port->tx_kick);
>   	dev_pm_clear_wake_irq(&pdev->dev);
>   	device_init_wakeup(&pdev->dev, false);
>   	ida_free(&port_ida, uport->line);
> 

