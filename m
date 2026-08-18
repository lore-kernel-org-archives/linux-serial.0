Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA425F988
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034184; cv=none; b=a/AtxK5RM3OkwXbHAkznD16oviSwDRjnj7VuvSumLsrsZQR1ooMIkJxQyXECw1L57wgqPYAXHa7DSTKyQd+UIeLvh0rQPC9CRhJlHeUZK46VbmuNBi+jFikD6d9AjnDoNa7rgxHJlP1PRQ4z+qrjUgsNPP8Ot/6T5if31GrYgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034184; c=relaxed/simple;
	bh=k/YYwgpnX/UHFEA6bDJ3GzHTqhHUVonky6mzjpBMS/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkUzjm4cgosoh3TLIFMNIIIhTVnp7k+mAIEolYwtHPbO+GOK6pbg4fpsYCzl9DF7Y9JZWJ/8qPh0e2sS57M2V1Nhntziy+6pHMvRnZoxsSUmQkzWFROjQ0mlmdlF5d0QoKG7je8dSEXBh/6589k/PcYeyZZ7rqsLScKYNFVD0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfwyyCLp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DEyx3ZN3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfwyyCLp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DEyx3ZN3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I2YMtb3761799
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k/YYwgpnX/UHFEA6bDJ3GzHTqhHUVonky6mzjpBMS/Y=; b=ZfwyyCLpyPrAcRDJ
	vwU2jee0z6Vklnk/A/G9ELJhjsuoGDXy7qdum8u156mn5KTbd9aB14Io9TtRftBF
	oAEc1i7NL4QPj0fwK1CqMzYk3tVZ2v7HRT6LvhDyXRAh9jEICy16vSgz/NJlLTKa
	1+vHXzSPqsPMVxZd11ivEWlm+ObMcTlXkfsunXR2ijWmq7mPksKaXYtV/PgErO+g
	mrsPIA9HNNH6+k1vwTuHrgXTKiiYGB3x2CluRp9HrIRp9SAMT7NNNu16QWoKYU9e
	xQ3MFgRPHMlYTMSWyXolXuFPEtOl2ihz7mB2WZAhOlx2wAfXcRMnPVzHmpVfCFpM
	2X63zA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtrv6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:23:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so5557722a91.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787034181; x=1787638981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k/YYwgpnX/UHFEA6bDJ3GzHTqhHUVonky6mzjpBMS/Y=;
        b=DEyx3ZN3tgFSV7fXuYgjIocCGecUWSrrFvQX01M3f8pSwx52vYNF0VPYTGHtzRxc3X
         +vwMDPwdNz9D4tPFTDeXfEOFP1EV5Yw9OxGjSwvVskaX6xGmHbV64t7m2+UipAe9BCUH
         Z5LuPrhTj6a4Ua7K4Ud5+DLlSHrFBkiBwGubZSIR+7DeRhd1eoG5yU2USooIkiTxcDML
         gSOAen+bOkMK3w84FJ7dsv1+Wgc3NU33NmwPLjREyjCmwpE5HA6+5sJgLVfb9+CCRmbL
         Ofv7+qDSK8hnqW/4C/1e0kire1q7gWlzPxJzR6WLo6eqT1G5FchVHSLY/ji1FNLYEkLb
         f6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034181; x=1787638981;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/YYwgpnX/UHFEA6bDJ3GzHTqhHUVonky6mzjpBMS/Y=;
        b=grfOlTZmHFNehnBjdAQHk/VO+UiK13XiyNk/n7Wyr0VK3R03b+q0lPiw0PUzc4I/7B
         omPAWwOc4FM4sfGqHxj1dse6w229Xwt/eWHFM26OMKK6dWxtHWrUTm2goXwzHJLps8oh
         EuJ0C1iijUjXMxZZP7ebAIV9q/nsJv2nsYCwUPlAGVEnY3hzXjEFJWPAeiUAbnXdZsJF
         hZc1IEBJ8B7W/JrwEjr4K1aVS6khO9XVh4Im8Tfzq4cnxY9udgKfdKN24fve0Og5aVt1
         oeXOo4f2WqLP+XMw/8I5pzm83Hvv7L/0mg3U8qSKwc4CwMcDGy6I7I74fKux252AjtAx
         42sA==
X-Forwarded-Encrypted: i=1; AHgh+Rpf3v3mn1Q4ov0KI95EEy6VJwrEV3BUNJ/CFlsgUNm3KoR4gwJIdn5+1ZMsx7W33tqB84t4cVt1yjIH+0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1q4qiA6uwd3hogOHM8YC+dO2w7xTTLbIRgfUx+HA51sDp1mnJ
	4ZUunUj2rqEkRcVXLTDaD6aEnVU0Fiz7xoxkXrNAzlVNwQPKS1jUmaNfrApJsY08WD2/RiIbrQv
	2D/qd9WsyAbtZCejS7Vg0Q6tq8PfFAoATnZw+Y0vqBP/6JtvRX4S7Vpuz5e2qIy2hY/M=
X-Gm-Gg: AR+sD139mxpWNYo/lD4MdWRHq3OGAh/TIVHl8Q1poM5OXlPF5+ZTVAp8FOOOib0q6c9
	wkE9v++SJ30n5O3WpfYQlfnLvG6FTUIQKd1G7gc26BXAUphfCz80rUmokpfDaqCr+YG9lH3Ofwk
	MpyyfEY5WIeeQnELv4U4Zz7rcL8qAKRPPUY2ocOjqXJYr60t81+IrukLdcZyNU6VE9kO0XsJsbU
	VRMKeK8hMyFx1U68ql21GtGHzxbWrrk35GVl4krGaDP2wJ0xDvmyy1i33ywq8kZ+I2am7f1dAFZ
	1SLZ92es34Es3JI/McLu125LFCCKhNeQUtkdwfDaPEvpVJ4ixPCmeIqgqIl3mNstisIFsElrDLV
	g9aoCOH2sA/5m+DvHoNRjoRU=
X-Received: by 2002:a17:90b:3d48:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3933b8939dfmr33374728a91.12.1787034180780;
        Mon, 17 Aug 2026 23:23:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3d48:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3933b8939dfmr33374673a91.12.1787034180269;
        Mon, 17 Aug 2026 23:23:00 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm8067273a91.5.2026.08.17.23.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:22:59 -0700 (PDT)
Message-ID: <078e9ac4-232b-4f1d-bb29-724403332b96@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:22:56 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081744-vision-coherent-8b62@gregkh>
 <03ebb6a0-2a3d-4260-afec-15e7e9925842@oss.qualcomm.com>
 <2026081849-camisole-enchilada-f5f8@gregkh>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081849-camisole-enchilada-f5f8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfX+7jH9Lu1efLm
 YdQGb9aqY/mnpF/S/3mHS10eDIyAihLqmHKZX2K5k0cSLFlCKrXlkc047sQOt1I9aMxuG4dwCuV
 URxVgzOfdkiYAizQRD2GYJ5snPSO4r8=
X-Proofpoint-ORIG-GUID: cmD9Ez6swIYnNeHUtGCIlsKbhzCIeAb4
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a83fa45 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=OQsXCNhCQip-qhD7-CAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: cmD9Ez6swIYnNeHUtGCIlsKbhzCIeAb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfXzORDXF8rS4KK
 gUkl/f55lN3PMpdMGdP8NI+T+NuXhdiIEEIS70P2EGw0HN1HcUkqLsw8PIArO1UwsGNvGrDdNYg
 CKfQED/iUowC9F3ThmFvgnMfuFlZDbjnL+smb8zL33QZmZFSjRy9tLU0NU88xyGWz9c8U+HY+LA
 uH3HSs6BYmyy3pP+iWq+bzs5oBU3I5D9B2G+nyz4YoxmupbQDVn4mY2PWGN7ciRtyZDpCiuvZZM
 1D/PimTmTFl7uuzTEYYa8IpGl6XhzBzehqIU2fkkDmCTYJfYABvzuo6HsUiOhzLgXdVhpF4lMLn
 tdzh1cTW6+Q2fQJZyrx3vNhY3YsYzJOF+KYiEP1Yj1fvqcdYI6TtpqLeUAwcQ3KkuFXNpo/5Tr9
 MtLYTR+vBOq1ERIBYOEqtE6nJAgttAEA3T0kBLmy+9iTCRgZmDANRqyrdJq/ED7w4yGHrM0d3WT
 FV+pYHKF89KMiE73/Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180046

On Tue, Aug 18, 2026, Greg KH wrote:
 > That doesn't matter when getting patches merged, otherwise no one would
 > ever use the newer and proper apis.  Please write code for Linus's tree
 > first.  Worry about older kernels later after changes are merged
 > properly.

Understood, thanks for the clarification. Switched to kvzalloc_obj() in
v2.

Thanks,
Xin Chen
