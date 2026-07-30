Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925134446F7
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429264; cv=none; b=hhRsp1lDWOrnr5JvjkJvo/qF4lbKvWwvxsE+TMkZCk9bemYJAbn2GHyrIS5Rln20h5qTiAsGVCh5QtnZF4XcNk7VzxbS2XlEeE6mG9hBpAGJz1ng6z0UAm+YqmTrv9zU+NwJaLjiNt/HLfJR4s/qeOhSVXSQmlwmxvskxcaslcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429264; c=relaxed/simple;
	bh=/ItBIOPawXYNwAswd6tU9RRlpCU1vzYrY9wUqopKFzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gtbl1558pyIanU02u3Myxz83uID/lxZ34szuLrXpSMR8GI6WVMs6/tnxoiemiPNPMWvr7lvBYxAmKB2sPt6hqImLfGo8QePIWYt+aKHXponrBTmT7jFAVyAtqUjkluWL+3v+Sg485dRnzIVSdNveMRN0nJMqr1M3ZTbRcjiDIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aApoPp4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SMQVL67e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aApoPp4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SMQVL67e"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWiWZ1379649
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IKNH2juaex08xlmIycCn4O+g3eG2ZSGfqAkX5dJNlEk=; b=aApoPp4b0e+BKO9q
	+sdqEimE7lSZ6e/yDktabAmXMzTC03CGajP+kTFLy9JUnXHmTjGBVL1UmtSbMO1q
	q8a+R2qoPNBZaHEeHBirFAIRlVrFmzOQcntPZvjdNmGZpbybaG/uBnQIqV/4T/eQ
	KSEoFbT06uBsrNzhn1NxNPG5n4AgdjTPTR3YTxMTK1s5MApjumhqLakzJqxZFvzQ
	DR9G4lLL9O959y4NP98tnZvU4Ij7VtzdxcjUB614a/jgP7yrEMKMm3o31VEwQpVo
	zCZyobn4dln8kQSmfW2VitneGyoLtwPcLzzdJkO6aqNwf4IMFTxBLbnimz/InHkc
	7ByIZg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0nae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:34:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e21552dso533185a.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429259; x=1786034059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKNH2juaex08xlmIycCn4O+g3eG2ZSGfqAkX5dJNlEk=;
        b=SMQVL67eyetFYP/pEH48rMeQdZr4XD6VfWJFdN3KkMQF5COZIQBrEU5z8GXCyc9gD8
         mBpRh0VJant6z1Bui/TSkTkaaSm/8/a/ghk/UkujuaUMEWpROXZ13RCagsB1eEdayuKc
         o5cIEyYSiIQ179RuOaW68IYDqMtlSM2lEoXMNzPa3hpAzAn4Swr/etwieJX91ztsJMMp
         3CoxkcMMNod2ySzxyRMtidmhY/HkdNbsjD3HAMWbRIrNyKrJjko0gKTj56WzYVdivevN
         CkGqNHxsXoMIzC/FheVAXagB/layavNLTWm1ts9T1tsLzSIvY8DQAMN8OHk3l4utzbeI
         v5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429259; x=1786034059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKNH2juaex08xlmIycCn4O+g3eG2ZSGfqAkX5dJNlEk=;
        b=bH84I7kxjXs0Ha75KIA3Xth0yfd0p/jbISBinfy6qz8UeHLH3M38TZd2WcIJGwr9BW
         AdXbDSmEzQilh3w0duwQP0UnwBVYezlVLW59GcFEjMVNCn4p30r5TeBIIErKKut4dslr
         GVLak8+iZoYm3f5Kauc+bSAcnO8hLGpp2eel64xw3nJtzSRo48U7l956yn0wIJtmpsf6
         sw2r51ajfxnJy0TFPt6B8oeYfMjEmR7Qm+eDnbxVP18Q8QOAEATYK+cHCtL5zMHI7HLU
         wZVPZMvq1FeqGYyQY0NeJjH0XjJqEUh7m2FS4PzglopVDrFBeASbPPOVR2J2n4BBIiI3
         xV2A==
X-Forwarded-Encrypted: i=1; AHgh+Rob9tf1MQdeR5c4WgmcYqQQg1fLeBTxc7KiHKCYaJdqFgdlZOnx9Z1EyF8n+9Q4CDoptxKLRAhc5hYQIgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzraQj62LKLAygDLv6YzH7BqsrdMcHIRCPyOkGMLajtSMbB+T2y
	ICWZogdNy6E/B3GYprlOz2sgrPf/2oltK4mWED10bc1up7hx0iWV3V2M3hKFxHF0pVj8PnQmPsR
	JA3z5zqzKUBUvwe4TvwvwKdKl0qYqx9sqKblZ5Wsr+gqoLZTymGjZQCVKatCzohJ9I3s=
X-Gm-Gg: AR+sD11E5yZ0ITRxOXhbhFZ3WNdMNv7lhrvS8ZO3Jk5Ik2u+3/OSgRfJI9ZYtE/wwo4
	lDwtsl00LPjkSKmsvY2+ARo/4weyEpJG3wRuiw6KdKukEzpu7TUe0+gIQJxoSfG+1vEX3vuhaG2
	h+pu/yguW6qNDv2dF0AnX76gv7ALed9Ug3fFSsKBfLKuO20j0/krGpbRt+whjMJpKj6c8MnJTUc
	ZLA6agA7nINQVPTIJTmjgcIbBsiDn1139dqn7sLoXViljrRvrMHEPJ1lFY1qyrvH+Oarzrn7oZJ
	e+dGWpScTAg3OH0QbTbiNQEJVNzcIirVwtS/+0Pc77KVH9o22DhLOFaUeiAWA0TBl8SZm9cK8Os
	4XPFZ4Yd8dWTZtRilAw7dNUNz
X-Received: by 2002:a05:620a:2707:b0:92a:d10e:bde3 with SMTP id af79cd13be357-9348dc47b06mr196850785a.3.1785429259237;
        Thu, 30 Jul 2026 09:34:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2707:b0:92a:d10e:bde3 with SMTP id af79cd13be357-9348dc47b06mr196842885a.3.1785429258737;
        Thu, 30 Jul 2026 09:34:18 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bf20a9sm86982166b.58.2026.07.30.09.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:34:17 -0700 (PDT)
Message-ID: <0fbc8b4a-3920-4504-b1ec-62894def2d0e@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:34:16 +0200
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
        linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        buses.k2c.reviewers@qti.qualcomm.com
References: <20260729-qcom-geni-nbcon-v1-0-3053b96465ed@oss.qualcomm.com>
 <20260729-qcom-geni-nbcon-v1-2-3053b96465ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260729-qcom-geni-nbcon-v1-2-3053b96465ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfXxMLIQJ2OJSQ6
 FS9YegK98XJDU6NOE4VEuvkRPHbcrQ7QjTc/0cirsS50tGGFJI+crRXWEf1v0z4VDJ4x1sgjaqG
 sYfkq73glUh5wUEeC7wXN5GUVWJx7zo=
X-Proofpoint-GUID: -v2q5m4TCiOhARuDf-PBeeQTwdeN6Yxk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfXwuLcX8VZOcTF
 ne3U5pOzxQcB1IsB8f5bX7QnM+whj+2jKmK+1PWmwgbP3OxvvwPyDgizZwQVo+DB9KC4EgAVGjB
 WfL7Y0ho/vhLsRIvl9s+KlP7iFFP/XOe3IAjrtV6CiTveZW8tZqEy78HUruArgFlFfAGeOaK4nu
 VwKucUG3tmvpyzmt2goKHE2lVj9b6QyMAwqTqsI1U27dvKtEM/OBhREKuWaQxcqklzZjG9Atu5D
 59ZfSZZKwVHpKbgEWkCb3QgtKwLL1J/WoNI7ILJ5Tk5Df6ic0YxO9Q1K/TkmdWmi7lzXidYBUre
 mIhYoZc2t0INo42Limnl8KxU+vNJgm/EV2wH5FtcoEEzLVtBwNIJlU43FmD5dbe8qOC3h5e1Z1M
 eQs9uc3w2V9twhqR+xWXlHbgq/1gBI3bl5mOLu4khNzQvp1PmNOFlU/2d96HBjy2jcK8LluexGP
 xYChcYatsE25KsB2lXg==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b7d0c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zuUasCYdOxZzd_muCtMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: -v2q5m4TCiOhARuDf-PBeeQTwdeN6Yxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300124

On 7/29/26 11:44 PM, Bjorn Andersson wrote:
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

I think this looks alright, although my ability here to judge is not
superb..

+Cc Mukesh and the reviewers list

Konrad

>  drivers/tty/serial/qcom_geni_serial.c | 112 +++++++++++++++++++++++-----------
>  1 file changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 08427390c173..a473d5521067 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -173,6 +173,7 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>  static int qcom_geni_serial_port_setup(struct uart_port *uport);
>  static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport);
>  static void qcom_geni_serial_resume_tx(struct uart_port *uport);
> +static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport);
>  
>  static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
>  {
> @@ -493,7 +494,7 @@ static void qcom_geni_serial_wr_char(struct uart_port *uport, unsigned char ch)
>  
>  static void
>  __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
> -				 unsigned int count)
> +				 unsigned int count, bool poll_rx)
>  {
>  	struct qcom_geni_private_data *private_data = uport->private_data;
>  
> @@ -525,6 +526,8 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>  		if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>  						M_TX_FIFO_WATERMARK_EN, true))
>  			break;
> +		if (poll_rx)
> +			qcom_geni_serial_poll_rx_fifo_locked(uport);
>  		chars_to_write = min_t(size_t, count - i, avail / 2);
>  		uart_console_write(uport, s + i, chars_to_write,
>  						qcom_geni_serial_wr_char);
> @@ -593,7 +596,7 @@ static void qcom_geni_serial_console_write_thread(struct console *co,
>  			return;
>  
>  		__qcom_geni_serial_console_write(uport, wctxt->outbuf + offset,
> -						 count);
> +						 count, true);
>  		offset += count;
>  
>  		if (!nbcon_exit_unsafe(wctxt))
> @@ -612,7 +615,7 @@ static void qcom_geni_serial_console_write_atomic(struct console *co,
>  {
>  	struct qcom_geni_serial_port *port;
>  	struct uart_port *uport;
> -	u32 m_irq_en, s_irq_en;
> +	u32 m_irq_en;
>  
>  	port = get_port_from_line(co->index, true, NULL);
>  	if (IS_ERR(port))
> @@ -623,15 +626,14 @@ static void qcom_geni_serial_console_write_atomic(struct console *co,
>  		return;
>  
>  	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	s_irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> -	writel(0, uport->membase + SE_GENI_M_IRQ_EN);
> -	writel(0, uport->membase + SE_GENI_S_IRQ_EN);
> +	writel(m_irq_en & ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN),
> +		uport->membase + SE_GENI_M_IRQ_EN);
>  
> +	/* Atomic console output takes priority over an active normal TX command. */
>  	qcom_geni_serial_console_takeover(uport, false);
> -	__qcom_geni_serial_console_write(uport, wctxt->outbuf, wctxt->len);
> +	__qcom_geni_serial_console_write(uport, wctxt->outbuf, wctxt->len, false);
>  
>  	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -	writel(s_irq_en, uport->membase + SE_GENI_S_IRQ_EN);
>  	nbcon_exit_unsafe(wctxt);
>  
>  	/* Restart TTY data left queued when atomic output canceled M TX. */
> @@ -655,12 +657,25 @@ static void qcom_geni_serial_console_device_unlock(struct console *co,
>  						    unsigned long flags)
>  {
>  	struct qcom_geni_serial_port *port;
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	u8 sysrq_ch;
> +#endif
>  
>  	port = get_port_from_line(co->index, true, NULL);
>  	if (IS_ERR(port))
>  		return;
>  
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	/* The threaded console writer can receive a SysRq character. */
> +	sysrq_ch = port->uport.sysrq_ch;
> +	port->uport.sysrq_ch = 0;
> +#endif
>  	__uart_port_unlock_irqrestore(&port->uport, flags);
> +
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +	if (sysrq_ch)
> +		handle_sysrq(sysrq_ch);
> +#endif
>  }
>  
>  static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> @@ -902,6 +917,34 @@ static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
>  	handle_rx_console(uport, total_bytes, drop);
>  }
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
>  static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
> @@ -912,10 +955,6 @@ static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
>  	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
>  	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
>  
> -	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
> -	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -
>  	if (!qcom_geni_serial_secondary_active(uport))
>  		return;
>  
> @@ -949,10 +988,6 @@ static void qcom_geni_serial_start_rx_fifo(struct uart_port *uport)
>  	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
>  	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
>  	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
> -
> -	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> -	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
>  
>  static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
> @@ -1182,25 +1217,11 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  
>  	uart_port_lock(uport);
>  
> -	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
>  	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> -	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
>  	dma_rx_status = readl(uport->membase + SE_DMA_RX_IRQ_STAT);
> -	geni_status = readl(uport->membase + SE_GENI_STATUS);
> -	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
> -	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -
> -	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
> -			      dma_tx_status, dma_rx_status);
> -
> -	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> -	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
>  	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
>  
> -	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
> -		goto out_unlock;
> -
>  	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
>  		uport->icount.overrun++;
>  		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> @@ -1215,12 +1236,35 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  		port->brk = true;
>  	}
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
>  	if (dma) {
>  		if (dma_tx_status & TX_DMA_DONE) {
>  			qcom_geni_serial_handle_tx_dma(uport);
>  			qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_AFTER_SEND);
> +		}
> +	} else if (m_irq_status & m_irq_en &
> +		   (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN)) {
> +		qcom_geni_serial_handle_tx_fifo(uport,
> +				m_irq_status & M_CMD_DONE_EN,
> +				geni_status & M_GENI_CMD_ACTIVE);
>  	}
>  
> +handle_rx:
> +	if (dma) {
>  		if (dma_rx_status) {
>  			if (dma_rx_status & RX_RESET_DONE)
>  				goto out_unlock;
> @@ -1237,12 +1281,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  				qcom_geni_serial_handle_rx_dma(uport, drop_rx);
>  		}
>  	} else {
> -		if (m_irq_status & m_irq_en &
> -		    (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> -			qcom_geni_serial_handle_tx_fifo(uport,
> -					m_irq_status & M_CMD_DONE_EN,
> -					geni_status & M_GENI_CMD_ACTIVE);
> -
>  		if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
>  			qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
>  	}
> @@ -1632,7 +1670,7 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
>  {
>  	struct earlycon_device *dev = con->data;
>  
> -	__qcom_geni_serial_console_write(&dev->port, s, n);
> +	__qcom_geni_serial_console_write(&dev->port, s, n, false);
>  }
>  
>  #ifdef CONFIG_CONSOLE_POLL
> 
