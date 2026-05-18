Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E221364EB1
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111721; cv=none; b=TybqIPQP/JHSp6ttKaRmLUCEqGabetfX57IVzPfKIuspjEXATOWZT5wAekqnQgsvvf75UrAmAbPh1wPdNW/7csz0rAKyoeZ5TXWXnuAWjD0kMtP4+QOqcqpIxLcQCVauFVjzlQBvIYauyA0MUI5m0UH361I5m9ppHk48byG6FfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111721; c=relaxed/simple;
	bh=ERa9KGcfFMbzXPZhSgeHUPTZ1z2PRDKTu5+uRwX8ig4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjZvnVAHpX0Ux6DwgBljws+hw2Y5EIl0WRGcas06PO+X2wbH7ls2hWK9OJQXwMQU9CTxugFu6DaxD135KvDcFmmIJ8gbsPLWYiJC3/1JmJDJHJ4wcvrCCPkap79a7jqqTY+zTAVlztLJWag6qtiIRwvt1Tw2YWRKlC9AxLzEpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvsvNBvh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y/VxpBFx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvsvNBvh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y/VxpBFx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHRWP2482391
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jOQ2L+lUTrqPio0b+Bre2mbX+LErk3gfKwpcIuQXOGQ=; b=XvsvNBvh+ImGM9dN
	EdvOrrKes25dpNpUss/uQAOFvfr0/xfL0bzSQ3sbYtXci5su81V//SSSZoBWRNlR
	jGFVn7vYFxOyaQ/GmY+rWyHbwWi/exKMmBUZAhCGJzWKBXLmdMRcz09KsmR/gY/Y
	hsYk+nlcDcNHpRZieUfsWMkOX2zxRdaVqZizSkz/jWPjiwqPKzglUG0Yq7qTEc5u
	KchQBnfbhuRleGWfJ1TIelvBETpmr8Nsrhzt2Q/WtZuYkqdpiBDRvFqFEltKgppX
	JjNt6ZPLNJIh089N7+TElhTnk3V8AKshR52I5SkxIuL9JiLLdB5kdtdjN12MAu98
	ymo+dQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvgh3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:41:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e62562b6aso8268251cf.2
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111715; x=1779716515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOQ2L+lUTrqPio0b+Bre2mbX+LErk3gfKwpcIuQXOGQ=;
        b=Y/VxpBFxQbFyjfpc+EGAwWIlEIKvWl67tCv8rf2VKXqRL4Mr+woYMp2U3aFBTlVQlr
         wMfVN+Y9qKWIUBuJTbDnnt+xb9s9iQkwELaLJKc9+xRluxJcO0whCJcoVoP1OMxJMCcO
         qcKDP6DuPZWuTPPT1DA0PdA35fwSwlNyaP6r5Rbe2bEi2VeLKLhBgfuFXWj1nZglLrHN
         aA1lDUrKhfepCHGWGKt1lQX+0BG6JvUYBcSK3h0OFN3ZeU6NcgOeKDqsIaGtZERlJE8/
         qm5CaDhKZbjBGaqf2fFI/b74YGtssnc4oUB4PY0yoMqfLXoKMfLCn+pUsljkshiTMzYG
         gDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111715; x=1779716515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOQ2L+lUTrqPio0b+Bre2mbX+LErk3gfKwpcIuQXOGQ=;
        b=Q3e70AK1qTeGNN3mxc6jZ05pFhq9O9aZc6EM31UPwT+1vcw73eYxQRsnM/2Jg4Z7TU
         hNDwfhP77tZHZXCloQEcnzA0O57oC2koMAOP5sGvdOiqO9szsfe0ivpdUDuGUMdh1tuG
         aHnYBWxESKUpqsVAnraZ36vtBpJihMAleKZhJQCbfYOs5+dK/GFBIOVbPHrPxdCGLmAn
         t+HiZu8BbSF/ZHDgh6w1tkazSJL+CPAje97CwSIO03uSmSvqBZdWjaSABYR90Q6i22aw
         fFJKgYNi+IqZoBRRWwIzG9FcM+lbYqB8buutWcr5odu1tSSnB0t+6O0DVIPxk7lvWPD5
         j1uA==
X-Forwarded-Encrypted: i=1; AFNElJ8thrF2zXLQQtJ54cGJLH5fF0HriwvDI1C3HHCVW6dieeB4roAsDf7It2mgG6wrH0a63UZXEbbX6libFOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dTDkHh7dL+okzuTpkB6LU6vp8FhfiaxSu5Rj7pW52DlMqJCT
	3JFDlDilDqULxhCWToy8/U976yVIfxJRZfr5ZnwA7EgGJg6NR4o9b8z1fH3hr8Q4dEtog+ZdFVB
	Ou9BYbuFvdgdJHundIG8kRHpoL9Xn2k5+ReorTffBw/sXkplXsqPV4WhR53NxI/CmS1M=
X-Gm-Gg: Acq92OFsBT6NajCDqGw9N19wjEXhCz0GpQwG9Z9Ibx2DW1L1PcTLWTOByBoatHk2MKs
	hRHt8p/C8XZjGQvWHgzXeSPFgxlwpZo5dWJqLgopMBNuMgMrnNrPnLU2kL3yHGN9hnsFp1i5Pnt
	JZNNsx6w4u9cDW9tJvnCZnlZ7wkM+wToRDgljBuYpchb7U1YsfZU81zs33l8sQiltO9fQkiH0hB
	/XKX211OQpf6OKRJBMRH3EqaAfV7JYJK7RSDvm1VrcWvdSTTHQTlvMv2ufnWqO1R/H/RCfswHXq
	Yuze32ulnwDdc6S5UoWY3pkt709dxEhNvActdOx0pWSUOgW38QlKg86MCHzuxJhkqs3cHvsfOSb
	m8IZsIcPjfMuZKDVCY+kgvU7NzoEDRirHiruLW4h9hVNe0fu4nTk4FagZ+vsOaUKwz5nXZvrFBQ
	CkE8M=
X-Received: by 2002:a05:622a:111:b0:50d:5af1:65bb with SMTP id d75a77b69052e-5165a1e7299mr143825031cf.5.1779111715486;
        Mon, 18 May 2026 06:41:55 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:50d:5af1:65bb with SMTP id d75a77b69052e-5165a1e7299mr143824661cf.5.1779111715037;
        Mon, 18 May 2026 06:41:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea94bsm563155866b.33.2026.05.18.06.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:41:54 -0700 (PDT)
Message-ID: <a5cbe0f6-bb58-4d73-a5d9-5680accb25b9@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-serial-v2-2-a5726421b3af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-2-a5726421b3af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX33tz99vzTUgt
 Vt72YS2c4ZJ31HWPU0LMFJ8EGUrSXpoZRZgYM0MP23GOEecC/+X3S9bfPBM9LamoAEYO4ruXh3F
 5R3iTN0WFRQcWrNT6U5hbKXw2TXPdAkzfYb6xs1ad9kwX2OKttQ+YslCtPW0JDPB+wrGEq0lLg7
 PoA9Mw1ZB2TdabGszQcyCN1SItJEtChZc/UPLCicTX9YWp2j+wZl43vAHJdpnfrzyWolVIY+sqr
 bDONMlmnNgYFxwpefL/7Jr0cJuW/PpNClMGCRVCvD0bQSDaAjuuwZESp1SbENvXcRafdhw3TI2H
 xiwP26bLy9c//b7SUdhTegQrltjMS2Xif23WgUuN6yijdN8KueQEM2rl/AAIpx1FCUp0IPWfSEX
 wnnBDqVFuNcqHTsHSfn3mDbxM/VPLze7oFwaWe4SQDxCg66KUUF/M2EShoniu1JGKZSK2YW/sWS
 lN1pzeyG7L9up8iH4Yw==
X-Proofpoint-GUID: sd0FLfCFfZ8q6jlzQQjZ-y_grnx6g-yE
X-Proofpoint-ORIG-GUID: sd0FLfCFfZ8q6jlzQQjZ-y_grnx6g-yE
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b1724 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vhne2ItbJHd0rvwzwroA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

On 5/12/26 7:14 PM, Praveen Talari wrote:
> Add tracing to the Qualcomm GENI serial driver to improve runtime
> observability.
> 
> Trace hooks are added at key points including termios and clock
> configuration, manual control get/set, interrupt handling, and data
> TX/RX paths.
> 
> Usage examples:
> 
> Enable all serial traces:
>   echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_serial/enable
>   cat /sys/kernel/debug/tracing/trace_pipe
> 
> Example trace output:
> 
> 2517.938432: geni_serial_clk_cfg: a94000.serial: desired_rate=1843200
>      clk_rate=7372800 clk_div=4 clk_idx=0
> 2517.938753: geni_serial_irq: a94000.serial: m_irq=0x88800000
>      s_irq=0x08000111 dma_tx=0x00000000 dma_rx=0x00000000
> 2517.938803: geni_serial_set_termios: a94000.serial: baud=115200 bpc=8
>      tx_trans=0x00000002 tx_par=0x00000000 rx_trans=0x00000000
> rx_par=0x00000000 stop=0
> 2517.938807: geni_serial_set_mctrl: a94000.serial: mctrl=0x8006
>      uart_manual_rfr=0x00000000
> 2517.938818: geni_serial_get_mctrl: a94000.serial: mctrl=0x0160
>      geni_ios=0x00000001
> 2517.939165: geni_serial_irq: a94000.serial: m_irq=0x00400000
>      s_irq=0x00000000 dma_tx=0x00000000 dma_rx=0x00000000
> 2517.939592: geni_serial_tx_data: a94000.serial: tx_len=8 data=61 62 63
>      64 65 66 67 68
> 2517.940610: geni_serial_irq: a94000.serial: m_irq=0x00000001
>      s_irq=0x00000000 dma_tx=0x00000003 dma_rx=0x00000000
> 2517.942174: geni_serial_irq: a94000.serial: m_irq=0x08000000
>      s_irq=0x08000100 dma_tx=0x00000000 dma_rx=0x00000003
> 2517.942323: geni_serial_rx_data: a94000.serial: rx_len=8 data=61 62 63
>      64 65 66 67 68
> 2517.942680: geni_serial_set_mctrl: a94000.serial: mctrl=0x8000
>      uart_manual_rfr=0x80000002

I think the example (or at least the data that it produces) could go
under the --- line, there's plenty of docs regarding tracing on
docs.kernel.org

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
