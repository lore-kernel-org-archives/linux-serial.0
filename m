Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F362443E24
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513894; cv=none; b=TGIvIKp/TeNWr5voYQv7NUmAbd3+6wM/18l1H6J7P5EfdSW04DE+eRqV5BDpuWe0vuXLJmI/TfU/Wig8iTow3Frp+nQzVuyYCEW0u8rvsLa35I1+OKsNh66pMUEkoIJT7D2W6l7aaJcbpr8fZQ5npSo9dcgHuMhgpG2FPls5UO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513894; c=relaxed/simple;
	bh=+rl9fQr9azEqUQ3Fd2v2gvsx2XP2rBcE+78I6PeARIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Fub3j2qk+WeOC/eap8Y/olX0hdB2BnXL6Ir5uv5smFMymcvNaEAozu3EUnh7VAXPnrE8dHblrWNLI/cnHJYX5pLfS1a/bAU7zq9+2vONurQ2IiqN2SQuySb62CUJKdS7AjL8sxLescYA58ZLO8f5xMaoQwT3azm2HTrm8QOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OoFWnwrp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b7zgSjbH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OoFWnwrp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b7zgSjbH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mmOa3234630
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 09:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5FtMGmmAUhcPYjRJ8a2QKAQG+cJan4crC2OeXEZcwHY=; b=OoFWnwrp9THc95aV
	vaykirE2cuhR6hNv+Mj9cLD0w5YIoVokqDB0x+SHDr1PqOuHDDhdgfk+W2KjrkmG
	PV80+Xxw5HWFEcjDqFzYPZLwmWcATFjxrj/Lz/pichhWNBJVf2XCvJs00PuwEcRd
	VAi8SBKzNzAqBDYpGqAM24TENgtWIW1sJNCfKknr4y701vwtrox8JS+nHmm1Q/Bk
	PrrY0OR6N6SeMi7CTmicjHA8a86SGr+fDiBlvA3ygQHjH8AYO6431nn1AQn58VdL
	WUYjKVz2DSlYspWel8E0Y+3IUwMXYQ5t+O/ZUjV+TQseJRLgp4aF66uYK3MWRfZ/
	iqIuzg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r12ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 09:24:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e661ce1dcso14247685a.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788513891; x=1789118691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FtMGmmAUhcPYjRJ8a2QKAQG+cJan4crC2OeXEZcwHY=;
        b=b7zgSjbHA3vpm5zNc3yZ8yhMacW+m4Tt34+mHmn5dl17HnEd0fHIRABWpGVTPrkkRg
         jLwrjwMh3GSX04WbmpAlnDbiK4joLbru1LzzBoQCKTn2SJAOVVnujt4pInzcTi5DjbHi
         dQ8ONb2n3m4zvDN/xSHAu3KPTd3eKyKjT23Ll2nzus93k/oh9hHjIaa+LPVJKrMFxe1f
         nmJU6w6tERvUJKWRtNwEWGVYi64K7d7sbiWkfqswSvDkfa5FhsuobUunQNjs5GB66Ovv
         hitIaLujsCJsoluPcuoN7aX2IGWjdj2KSAVyDZh21rdR1XYVOzbrE0KFslPzlrlKYRqe
         bu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513891; x=1789118691;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FtMGmmAUhcPYjRJ8a2QKAQG+cJan4crC2OeXEZcwHY=;
        b=bWnyttwDHG9cHAKWfPMwblkbmR49CfuZKEKBPGvGnqxbQPstEHWNZxOSBwba+5o+Af
         yRkPMx/fDjJv8kBqrZV4BbbMyGvv2T36OVv0kDreoekVmnv6ASsHQggN4CRXgOyZqyui
         RriRDqW+zhhfSlo77UyIYvY5RlJboT41wkqXTpJ6W/X8oIUqC4fn53Oe3j14bl/FntX9
         4n8CwamuoEEd+rg/YUOocSIYz9oVFLuBn0OW07A/aWEeXXKpv0Tio+9bVLlnqXjC3kgQ
         vMALr0uuzmPkU3QhaUBcUe5f3R+zEECFJNvvh1Bm0ybKSRiTeooeQKQzVCX/JYvuaxXI
         PASA==
X-Forwarded-Encrypted: i=1; AKwUvBy1s3PwfnqZsFnFioZTJAbKDPmRbkDaKQWfW1EEuo7nwveUile7ONUP1RkH0mNevY7FWLRYXhu4BLI7PR0=@vger.kernel.org
X-Gm-Message-State: AFuF++nyrB+KEN6p1r5zPP9kc1tvN9rFP9/07Q5Wsd1gk4m9A16oB5k4
	5JbchZ8/92tGb/ylI+yqUV5LKBeO3g7Gp2Mo1LdFpS94ju27KFtjMFrOeloubGRo5FOKKpAKpCR
	XWjXXEnLm3WDVbIbv9MPV4+gKtyP7ZUyCgoHRWil+uFk8xjqHAsjauiDGCRk2AwRtQ5s=
X-Gm-Gg: AYBFou39kSPCRfihxppjMyWh9FHb2/iD8zhzeThao6lil/eT4wdam/C9SsguxqmM09/
	6k/tthVxCXxlvKmrKJyGgeG/DJXksXRu4QWHdldla7Lsl8Bj6pCak549YNNU5j7utC5mNor1M5G
	iYuCxA2OCxhzWGOk4ZH3hTkXL3e06HwDOQrZfGqHZFAvcZIKcqfLg5gWaT11dncsSX6TdAWQLsL
	sIYtBCr1C/ZtirPYuav0In5f+OLGORlGHd1YybNu+kydt06hACHZzHL4FuKP+EXZgc4+ZCauTDE
	+zOFu6DgEaSHbVWM0j2TnK+ftIbEQqsthSmWO6WhAX9P8do7qk8OERfpQ4MDfpiZYIPaklQgts4
	xUdDDEMwwecdjuB9lNdeRIw==
X-Received: by 2002:a05:620a:a0d3:10b0:939:8148:1e3d with SMTP id af79cd13be357-939814821e9mr181783985a.2.1788513886499;
        Fri, 04 Sep 2026 02:24:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d3:10b0:939:8148:1e3d with SMTP id af79cd13be357-939814821e9mr181782985a.2.1788513886047;
        Fri, 04 Sep 2026 02:24:46 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d501662sm83344166b.23.2026.09.04.02.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:24:45 -0700 (PDT)
Message-ID: <29755612-0ddd-4447-9859-ae781e8b3c5e@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:24:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: qcom_geni: don't ida_free() the console
 port line
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NSBTYWx0ZWRfXx1F1E4naHySS
 FkjmPp5CZSywmFhCfpwtR2ULuGhxTtRX0i15JtU5GbNuZbbQnjUuyjOep9i/wLfwXqGzcBZ7rg0
 zy3JWReogAOb4ioe6nUbPIf1J/z39FQ=
X-Proofpoint-ORIG-GUID: T1v85ZsyK6eJm_Kx1yqtB4onLKIr994a
X-Proofpoint-GUID: T1v85ZsyK6eJm_Kx1yqtB4onLKIr994a
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a8e64 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=DqZwqz_RRVBYWPiTFsgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NSBTYWx0ZWRfX0oH19N4TJUZU
 cy+CbypzowlAcKzFrS7SQe5w2jJ+9Pt3e2ezFIqKTGz6e2itkGBwExpw0wMsoHtlrFg29zui4aU
 aHcIFVSII4f3euxqtYAoU3PjbPX7n00VXOvUTZZTScUjvVjKPsjpqvj7U+R0103DBPxsKT/9B7q
 N8jJ8eqdFwcdi8pWdcmmv3VTuhn/jtKFgEWT5ZaWM4j70SadSziO4qP7JPS0hLdhgPeIffpdjCt
 yMdmCWCHNA6WSUkaZkT99SpFrJq5K9SU4CtCj759z1h+ggN97xz9O3XE4i6b+E0ORxyfzWCeOuz
 mg2mXdW3bHvZAFLTBTQJF6GqFjRLeuWhk/Z8etxIui3lZ7dXNAvyuOFbEdY+3dhRgcDmDe01IZe
 qp4stVM2DztWwYepYvRzN4Bx86RaDS/0S02XYH2mov7uOj3AgMy/wyKWRGBE3dAb5ZeVmBmGiLV
 yVBAfBZfIhxpU6gsY2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040085

On 9/4/26 10:50 AM, Neil Armstrong wrote:
> The console port (qcom_geni_console_port) is a static instance whose
> uport.line is hardcoded to 0 and is never allocated from port_ida.
> Only the non-console path in get_port_from_line() calls ida_alloc_range().
> 
> Fix the qcom_geni_serial_remove() and the matching probe() error path
> so unbinding the console device doesn't hit:
> 
>   WARNING: ida_free called for id=0 which is not allocated
>   <snip>
>   qcom_geni_serial_remove+0x58/0x80
> 
> Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

The robot continues not to find all the issues during the first round..

tldr: uart_console() is only a valid check if a port is an ACTIVE
console whereas we skip ida_alloc for ANY console ports, so in .remove()
the check should also be for device_data->console


 Medium: The remove-path condition remains incorrect for an inactive GENI console port.  
Patch line 326 changes the free guard to !uart_console(uport). uart_console() is true only when uport->cons->index == uport->line (include/linux/serial_core.h:24-25), rather than when the port is the statically allocated console device. If qcom,geni-debug-uart probes but is not selected as the active ttyMSM system console, cons_ops.index remains -1 (drivers/tty/serial/qcom_geni_serial.c:1746-1757), so uart_console(uport) is false. Removal then still calls ida_free(&port_ida, 0) even though get_port_from_line(..., true, ...) never allocated an IDA entry (drivers/tty/serial/qcom_geni_serial.c:279-310).
Use the same ownership predicate as the probe error path:
if (!port->dev_data->console)
    ida_free(&port_ida, uport->line);
This makes freeing depend on whether the line was allocated, not on current console activation.

Konrad
