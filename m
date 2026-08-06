Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655633A1A22
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024175; cv=none; b=ZH4bs1Lmn3LC6TEXgQkD7Z3/w8NKRl4lBmj1FoyMaM11AxgmWkSpF0UNSe5S0dejW+/01H8hrNUNbXjAnA+wtSb57tgKFg5Qnb/OG19dOto7035t0LwLM/P/jyFG/FK8GckdHMq6Myc/JN0ImuYfHohy8BmBy2mzsmySfEZ9u4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024175; c=relaxed/simple;
	bh=veZYvdy3BbKx7nf5+9Hx5vWe8lvuOx50756lCzRPh9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTwe4ch9dLcHTH5O2gb3K+jH268OSkXHjqx6MsGyhfAAd3WY2JsTtL9HpVi3WivgEM0z+BWIrjVsFKVxYcXHiE+QNo/6UPc86oW1eaeyd0L9vu7sPffwJXCPfbfbKvG2mKUH9n3WqFeYo5/fCm+/vguwSR+JcK4YfNrDOaecj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rkrnw/45; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juwp4QUF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rkrnw/45";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juwp4QUF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhnI1871348
	for <linux-serial@vger.kernel.org>; Thu, 6 Aug 2026 13:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZxl8iAXDTKTxTEzb8HY6DNron3ifIJkfrBCUw+RCA4=; b=Rkrnw/45U+l75qKI
	GLOEVgCV7c2mieKPynNIw0gJXneX+fL5dvpIvtgqQ+Y/Xkt1Tat7vxrA1/LPxn6e
	hw0BRNnqdA3nkI6Sr/sJR68wbqkZU/Cii4IUKVZ93bbTUKDP69wzmXsq23PkG6VB
	itORMfxIpOhIdlsfgC0Re8AlDSfalb/q1lbhsN1YLdV+FrfbaFOWsqPNc0nytqkS
	77KYXvHW6DIj+Cux3wFFR5ywp/7pb4T+2QihI/53J8iP81R4oVDZjHMmimS3kQ6H
	mpTQadOu15PSw2V5L8yFwtcVg4bdeZ3NJKGDJNv+rtWioXH3SfVAydRe66LvlAKf
	i4D4Xg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud2efg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 13:49:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso3801774a12.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786024171; x=1786628971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZxl8iAXDTKTxTEzb8HY6DNron3ifIJkfrBCUw+RCA4=;
        b=juwp4QUFNG/u0YYnMj/m1FrpCVzKmgNwM9Us6ehBbD6C79hB1VDnYZD8popPH6kiaH
         hS/U3Iez0eIfXRO/xV6lJMi2FD4ltwuHA3+jf6sGDWOhYMHti6H8AWyhriUfvC6e4y1g
         vOmItLzXt9CfoTHsBu0v65xo/GgfervZJur+JYDDVt4EbONiosoPDxbhzPnc7Ih28cXn
         5MPwVqMwoNlpM3KUfeZ51mwdFPMjGHWeBoD1/R5s/UtRocYI9fajYEsL7rKxSVL9mOnB
         nQZezkFa7xFtaXAuXFhhzW6K5hQAEBPz5UnGnedu/6QBqMFXsremfS+upfK4zRPJEGCj
         oA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024171; x=1786628971;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZxl8iAXDTKTxTEzb8HY6DNron3ifIJkfrBCUw+RCA4=;
        b=RTWzyioLDNiXgZQDLG2ggrc7B7+yZ44CDYi3CmH481iF2x5+exr4dl2K49HFEquxb3
         ifVldPlh/PgdktXtPHi1NHEPJEVuMFOyIXypt4N3sHiYRRzG2bGlSRbUuASxrHrCzRJt
         CPsKjOj6LZ1Rq1H65hz+T5AKxkIo5mrM87deyH2dlB2PWLbvjlvBKwjuPa/qhV7K3Olg
         +adWuDVPDrtWUqm12uNyLa/x9NpGipet4lpMyBFxQ/ksTWpAJ0x9+N2rsFdN/DBg4J68
         9bIOpEpQmFHzR/+19XkpTcBcz46c9KTvxoTBkeKlj8OLwTDV7ErXNF7RAsTHztNyq3I0
         FjEw==
X-Forwarded-Encrypted: i=1; AHgh+RpZB5uNBq1yDKGC88eGtX8Cp8cDzxM5jkBnqWK86Dk+eudpynZEPLUx3mimHym2MmEtF7AvuXZV9Ffn50I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDSUjRmzgUJgcNZ+9ot8uPLWXGh7STPF4QzHs1ehY2OLIxR+e
	lX7QIc7rpH1rQPIfVGHwpWbjzwhwFZ2NX7n8tZsb9E5+ck/XYT2lqrPYG8k9rTJ53CxpsSqc/+N
	RkIkqN+yfU162eC/d366FauKMUxZ+lLHLfzrb35tKfuYLDGlMg5dJIjKWRBjNwnTmOzc=
X-Gm-Gg: AR+sD10j66qwzyCELLpMuCP/AggWLLbTxIXQJT7ow0QHABpjipHXKHfVvXsADa3EIAb
	9yIrRyJkfWmAE0PYGngTmtsrkEyzHzFdlRULegr6W6++i15DXqT49FZT2gKu0St4z+k+zloLBCf
	NOa+U2SXyZUNiDPHslBFyqv4q96tsO4Yvkzw2PXU2W0l7PNvsT9dDTsHqEjUVwhk30zqWHRU5n5
	6oLlt8YwteCSWV2iUCYJdDfcRzkZ5E/bqam0BIvSiXkCjBN4MeioTzvwoWChV1ZkpDhX+fzj0/r
	z4yDRtDGPlUUUtpK/3SzMf2hgD+r27T1QXjN9wBPx6E/dUJKMMhcMjfqEHIrHWaH7XDPe0iJFos
	rIf+WZh8M+LykVa54jACpm5FlrNOMiZ8/TQ==
X-Received: by 2002:a05:6a21:e8c:b0:3bf:b9de:8570 with SMTP id adf61e73a8af0-3cb85e4bb2amr19432766637.19.1786024171082;
        Thu, 06 Aug 2026 06:49:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8c:b0:3bf:b9de:8570 with SMTP id adf61e73a8af0-3cb85e4bb2amr19432683637.19.1786024170498;
        Thu, 06 Aug 2026 06:49:30 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe7092b9c6sm2798045a12.31.2026.08.06.06.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:49:29 -0700 (PDT)
Message-ID: <39630fe3-2af8-4f39-84cc-c3fcb5726e44@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:19:25 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: qcom-geni: Keep FIFO RX active during console
 TX
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260729-qcom-geni-nbcon-v1-0-3053b96465ed@oss.qualcomm.com>
 <20260729-qcom-geni-nbcon-v1-2-3053b96465ed@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <20260729-qcom-geni-nbcon-v1-2-3053b96465ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXz0uXtgPHmvBi
 N7hu5uP41EV2g1Rg514A9aSBnbLKvx9h32alkzDT19+JGK6VJqy0jrZfSaA5MPO86n9wi6k/0vO
 7k+pr2YSXr7w0TrH4R1RW5UPEj6DLf77ZX7jMudyTCQhj0yu4379KuYmiEBlpGHdn+SyHlWNRtE
 xBNt5cgg1xFCL0wmwsiNzqG8FfULszK3snPnNzL3UZrUS+VU41o2p1ElSfwpb9mnlt3nPQMcUlS
 nVa0ralwxcV7R2dMQoWuDXSllkDNmF2mj8IKFPxtxv0/Qe5A+HT1E/qKTzPTV60ZlIn4RFJRVJd
 F3WcuSAlBwe1/IiJvOWimj8d+mxvDKb0pVzSTKX0WzG+/WoLvUBC63YQCUAEMLyr22d0boTrwdl
 7fjcPjMjg08ZkkHyhh6bikEEEeB4wnG4aAqfo9GIpXGkg29SozUUpWA1ElT1zLBywjTjYEGJK4x
 d6XUNT5zefJIqxtMDew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfX3kDzSIecvD5o
 dwI/HEXDISIJSi2S+SA/VdamJQbiFF3/Knf0rGEze0H0LlTnNkBPseLa8cYjK3++VjJmzrR6nNU
 4QAGcsqH8oB69TKE+aU5Bkyqcj+x+iU=
X-Proofpoint-GUID: bR0PQm-k8ZoLcBwrn3QzjLxqTUhqusb2
X-Proofpoint-ORIG-GUID: bR0PQm-k8ZoLcBwrn3QzjLxqTUhqusb2
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a7490ec cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7-Cdn2quy58rf2YawvQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060108



On 7/30/2026 3:14 AM, Bjorn Andersson wrote:
> The GENI main sequencer handles console TX while the secondary sequencer
> handles FIFO RX. Before nbcon, the legacy console writer disabled both
> interrupt domains while it performed a long polled M-side transfer. This
> left the small S-side FIFO unserviced, allowing console input to overrun
> and be lost.
> 
> The nbcon conversion replaces IRQ masking with the UART port lock, but a
> threaded console write still prevents the RX handler from draining the
> FIFO. Keep S-side RX enabled independently of M-side TX and drain it
> while refilling each bounded console command. This preserves interactive
> input during console output.
> 
> Atomic output masks only M-side TX state, leaving FIFO RX handling
> independent. The threaded writer can also detect a SysRq character while
> it drains RX, so defer delivery until device_unlock() drops the UART port
> lock, as the existing IRQ path does with uart_unlock_and_check_sysrq().
> 
> Assisted-by: OpenCode:GPT-5.5
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 112 +++++++++++++++++++++++-----------
>   1 file changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 08427390c173..a473d5521067 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -173,6 +173,7 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>   static int qcom_geni_serial_port_setup(struct uart_port *uport);
>   static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport);
>   static void qcom_geni_serial_resume_tx(struct uart_port *uport);
> +static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport);
>   
>   static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
>   {
> @@ -493,7 +494,7 @@ static void qcom_geni_serial_wr_char(struct uart_port *uport, unsigned char ch)
>   
>   static void
>   __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
> -				 unsigned int count)
> +				 unsigned int count, bool poll_rx)
>   {
>   	struct qcom_geni_private_data *private_data = uport->private_data;
>   
> @@ -525,6 +526,8 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>   		if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>   						M_TX_FIFO_WATERMARK_EN, true))
>   			break;
> +		if (poll_rx)
> +			qcom_geni_serial_poll_rx_fifo_locked(uport);
>   		chars_to_write = min_t(size_t, count - i, avail / 2);
>   		uart_console_write(uport, s + i, chars_to_write,
>   						qcom_geni_serial_wr_char);
> @@ -593,7 +596,7 @@ static void qcom_geni_serial_console_write_thread(struct console *co,
>   			return;
>   
>   		__qcom_geni_serial_console_write(uport, wctxt->outbuf + offset,
> -						 count);
> +						 count, true);
>   		offset += count;
>   
>   		if (!nbcon_exit_unsafe(wctxt))
> @@ -612,7 +615,7 @@ static void qcom_geni_serial_console_write_atomic(struct console *co,
>   {
>   	struct qcom_geni_serial_port *port;
>   	struct uart_port *uport;
> -	u32 m_irq_en, s_irq_en;
> +	u32 m_irq_en;
>   
>   	port = get_port_from_line(co->index, true, NULL);
>   	if (IS_ERR(port))
> @@ -623,15 +626,14 @@ static void qcom_geni_serial_console_write_atomic(struct console *co,
>   		return;
>   
>   	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	s_irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> -	writel(0, uport->membase + SE_GENI_M_IRQ_EN);
> -	writel(0, uport->membase + SE_GENI_S_IRQ_EN);
> +	writel(m_irq_en & ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN),
> +		uport->membase + SE_GENI_M_IRQ_EN);
>   
> +	/* Atomic console output takes priority over an active normal TX command. */
>   	qcom_geni_serial_console_takeover(uport, false);
> -	__qcom_geni_serial_console_write(uport, wctxt->outbuf, wctxt->len);
> +	__qcom_geni_serial_console_write(uport, wctxt->outbuf, wctxt->len, false);
>   
>   	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -	writel(s_irq_en, uport->membase + SE_GENI_S_IRQ_EN);
>   	nbcon_exit_unsafe(wctxt);
>   
>   	/* Restart TTY data left queued when atomic output canceled M TX. */
> @@ -655,12 +657,25 @@ static void qcom_geni_serial_console_device_unlock(struct console *co,
>   						    unsigned long flags)
>   {
>   	struct qcom_geni_serial_port *port;
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	u8 sysrq_ch;
> +#endif
>   
>   	port = get_port_from_line(co->index, true, NULL);
>   	if (IS_ERR(port))
>   		return;
>   
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	/* The threaded console writer can receive a SysRq character. */
> +	sysrq_ch = port->uport.sysrq_ch;
> +	port->uport.sysrq_ch = 0;
> +#endif

Nit: the SysRq handling here duplicates 
uart_unlock_and_check_sysrq_irqrestore(). I assume device_unlock() needs 
to use __uart_port_unlock_irqrestore(), which prevents reuse of the 
helper. A short comment documenting that constraint would help future 
readers understand the duplication.

Thanks,
Aniket

>   	__uart_port_unlock_irqrestore(&port->uport, flags);
> +
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	if (sysrq_ch)
> +		handle_sysrq(sysrq_ch);
> +#endif
>   }
>   
>   static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> @@ -902,6 +917,34 @@ static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
>   	handle_rx_console(uport, total_bytes, drop);
>   }
>   
> +/* Caller holds the UART port lock. */
> +static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct tty_port *tport = &uport->state->port;
> +	u32 s_irq_status;
> +	bool drop_rx = false;
> +
> +	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +
> +	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
> +		uport->icount.overrun++;
> +		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> +	}
> +
> +	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
> +		if (s_irq_status & S_GP_IRQ_0_EN)
> +			uport->icount.parity++;
> +		drop_rx = true;
> +	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
> +		uport->icount.brk++;
> +		port->brk = true;
> +	}
> +
> +	qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
> +}
> +
>   static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
>   {
>   	u32 irq_en;
> @@ -912,10 +955,6 @@ static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
>   	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
>   	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
>   
> -	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
> -	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -
>   	if (!qcom_geni_serial_secondary_active(uport))
>   		return;
>   
> @@ -949,10 +988,6 @@ static void qcom_geni_serial_start_rx_fifo(struct uart_port *uport)
>   	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
>   	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
>   	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
> -
> -	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> -	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   }
>   
>   static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
> @@ -1182,25 +1217,11 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>   
>   	uart_port_lock(uport);
>   
> -	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
>   	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> -	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
>   	dma_rx_status = readl(uport->membase + SE_DMA_RX_IRQ_STAT);
> -	geni_status = readl(uport->membase + SE_GENI_STATUS);
> -	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
> -	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -
> -	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
> -			      dma_tx_status, dma_rx_status);
> -
> -	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>   	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> -	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
>   	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
>   
> -	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
> -		goto out_unlock;
> -
>   	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
>   		uport->icount.overrun++;
>   		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> @@ -1215,12 +1236,35 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>   		port->brk = true;
>   	}
>   
> +	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> +	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
> +	geni_status = readl(uport->membase + SE_GENI_STATUS);
> +	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
> +	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +
> +	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
> +			      dma_tx_status, dma_rx_status);
> +
> +	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
> +
> +	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
> +		goto handle_rx;
> +
>   	if (dma) {
>   		if (dma_tx_status & TX_DMA_DONE) {
>   			qcom_geni_serial_handle_tx_dma(uport);
>   			qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_AFTER_SEND);
> +		}
> +	} else if (m_irq_status & m_irq_en &
> +		   (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN)) {
> +		qcom_geni_serial_handle_tx_fifo(uport,
> +				m_irq_status & M_CMD_DONE_EN,
> +				geni_status & M_GENI_CMD_ACTIVE);
>   	}
>   
> +handle_rx:
> +	if (dma) {
>   		if (dma_rx_status) {
>   			if (dma_rx_status & RX_RESET_DONE)
>   				goto out_unlock;
> @@ -1237,12 +1281,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>   				qcom_geni_serial_handle_rx_dma(uport, drop_rx);
>   		}
>   	} else {
> -		if (m_irq_status & m_irq_en &
> -		    (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> -			qcom_geni_serial_handle_tx_fifo(uport,
> -					m_irq_status & M_CMD_DONE_EN,
> -					geni_status & M_GENI_CMD_ACTIVE);
> -
>   		if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
>   			qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
>   	}
> @@ -1632,7 +1670,7 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
>   {
>   	struct earlycon_device *dev = con->data;
>   
> -	__qcom_geni_serial_console_write(&dev->port, s, n);
> +	__qcom_geni_serial_console_write(&dev->port, s, n, false);
>   }
>   
>   #ifdef CONFIG_CONSOLE_POLL
> 

