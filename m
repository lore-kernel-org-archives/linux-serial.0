Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7B27726
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190046; cv=none; b=VC81UtHMfHoQ7r5DEFEpQb9k/QsjF44juZc7dDoPZ84J80MblFHjla89tCumblpu3KBQrDX/ZH9ljdUY0ZrhbnqGPCl7R7x/W4LrTbo1Xrg2zcbehGD4UYM798+xCoF5/8gO9vtQUcjlIGJiNFQMwmZ4cDhOl5gh0ydYMlAkOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190046; c=relaxed/simple;
	bh=MaHkjJYwc8DMck7Xh9rwkZqfWOJBacfKsQYBgtQ+Umc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UARaih1x0gbgT4pqla3j9FrLOuODf78UiQW41Y3eiKsDJdKvmyCdBMfbHkx9af/lSwvjTGjDe/j8RGFr5Ss0yEvEy1dsI1QT69JL78nMXwvOhFn/dTN/DLVnTRe9B2X3lHrj4KtDwNc0TwVU9Vu30230wN957MMAmgbnODL1E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UHFidj9d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UHFidj9d"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8BGUk007556
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 10:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGOSNQ5nH47a+34ZmsmhGV0lPGcs11aQrS/2w7Sf1xk=; b=UHFidj9dVpLlZODi
	nDLsX2J00guAzO1R6kpuayxmCkoVrL679n2MCP7Ok8v+JzUkRjtFd2gB9vAfpEsx
	6jQ3khsk1Ce7wqK8w45V19ae8DBzNHOfClxu9fMXKjErjO1MwHnIoR3ew73HktPy
	bA0TMvb7Ta6w23VRpG6VzbQb74z0D3CeLVC231nZJo9x8y8pdv0t15BSnYw4/eZN
	UM7i88Xn0UG6G+cRcisvxz3qsNIHXzoH/67dYMSgwFmIf5Dksim0qWyuXXP7Ukh1
	uxqz8hWgTVcvCxuTkOHXPSfZmpiV82UCo0wNbYLkTyc4KPUDsDb9wgNyY/74Ef9Q
	fGElTg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebercb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 10:07:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-767e5b2a74fso7807996d6.1
        for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758190043; x=1758794843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGOSNQ5nH47a+34ZmsmhGV0lPGcs11aQrS/2w7Sf1xk=;
        b=FpPnmv0vzDb1pjYIKGxSA8ZH4X8ZyhyU0CVgBVhEpj8qIG/ydnrz+6ostf+/Qv3zM6
         Vxip5V1SKeYrGnAhMiL1IQOCAl0EGLht+QZagjfk9wAFViCmuKhdthbNORk/e7AWGiGB
         YV/K3q+c4cP07p8OuEQIDeHScrIghxvJIFZS57QQdL4EScu4vU6P4Ox1PaaRJRn0mR1d
         QGN8esz6DjlR97SfSGxvkd4778saeQIWIWcDRx8XDYcDx0VSW4Ujv2qtBeA3+Uqvht9s
         4tuOFdNVvoxpXO+vAJpJb8ablZ4JkQLDZ8yyCtdZWSCUYAT5ibu1hheJfpIR8A+hNNbz
         bbNw==
X-Forwarded-Encrypted: i=1; AJvYcCXulDRQUAjM7UnErluCVXxi6HjwNQfwGKwysNTw2lEY8lbpopXaLcow2QAFL/Dj+/vTFLN89kWWx/qwbDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1z9m7KC3Oh1a1vwi55dBMY4A6QfygmvcdMnjFJP9yxJDjq6I
	c/MNhzWRHTGfCkrXKI2Bhy8WE0L2FHQx4XUh5L3LMKatE9R1kfh/UAfS3BRQW/v+ftZOmZsEwu1
	QGvFV+jFulTm8do0suO82IGXKRomVVTWdCVSpdM6S4MkgO6dMJSwDP7C4CARr6HF533k=
X-Gm-Gg: ASbGncsWRut1c3BpnvoO6PKhVS2UOzzblXT1xLqNWJEBX1rxy3exdvJIjfxRljlrjLS
	s2RGD3JdPDQZ8o2QX6iLdHFqxYRRBnNFZDkt03kI4zwTbxgz8vkQDQ/QX5dejCC9IKTzZ8OX1Mg
	eqZub9rwkJLMFZ+P8Q5Wn81twXIq28mTCztTkm1mPmXl/Aelb9vmlRiWhyYXQ4dqQB9jVKQEjGS
	8xdsbZ+27oCvwB1DPTG1CSAwCM/jAfTVZPfzuFYX+Gu9i16rnL8MNjFcHZpoFxo/VR9cwIILu7e
	/JGi4Url5xfX3oqd/n2IcMUVik3hy0IddF/fKW/JCrIU4To+QkFYZLYkfBV1e3rNwP2b/dSNJSY
	=
X-Received: by 2002:ad4:5fca:0:b0:72a:2e5b:af2f with SMTP id 6a1803df08f44-7927b757c00mr27754076d6.30.1758190042461;
        Thu, 18 Sep 2025 03:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFBEfjc7Tkt/1Iv7IF+XCof1OPXKA6VZBfDMdHjBqN0oeH0J4tmyEMtrM4m9cQn6cz5NMfNg==
X-Received: by 2002:ad4:5fca:0:b0:72a:2e5b:af2f with SMTP id 6a1803df08f44-7927b757c00mr27753456d6.30.1758190041748;
        Thu, 18 Sep 2025 03:07:21 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm73363605e9.21.2025.09.18.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:07:21 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 18 Sep 2025 12:07:19 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
        psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMvZ10EsMif/DOP4@trex>
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
 <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
 <aMuz/C1iT8JtjXbQ@trex>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMuz/C1iT8JtjXbQ@trex>
X-Proofpoint-ORIG-GUID: xm9w8yF1J3htbzyf_rFipVuViRXMpUn6
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cbd9dc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=UD1JcZfzldWnGte6AesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xm9w8yF1J3htbzyf_rFipVuViRXMpUn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX8LBkblXZnYMX
 CDBntoNuadIhqc0ylYFfmo/XP/26V0UEyx5txj7Q0TuQsvDPu//SxORO083JqLfkP5Krm0puV5o
 xuGUHbeiZBK1/v3xk1J74WinDRo+saZX05nDslksEFyUSoeXbxIE+Jazkp1ANSWhIvqqvasHV9t
 JYp52iqecxKJjr0yx2vaYW5F148WwRoKquDuGT5UyDDydJuU6MAUQgtp9PDgVl/aEJHK24NqvkW
 ipbArKd2ZIk/EuySNT6aXtikLjBykcAxl575HDhcMcpQQW80IP5GHCS8WU5IbU+SEE3Y2B/e7Ra
 VBHuOjUDBalEIzepnMDHblze3TYUwkt9Eo/Eu+I1/mk/qXjBQHUFyxAmzBACtQ06lQc/XjN6/yS
 /3dCxxE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

On 18/09/25 09:25:48, Jorge Ramirez wrote:
> On 18/09/25 09:25:53, Praveen Talari wrote:
> > Hi Krzysztof,
> > 
> > On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> > > On 18/09/2025 03:51, Praveen Talari wrote:
> > > > A stall was observed in disable_irq() during
> > > > pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
> > > > while the UART port was not yet active. This led to a hang in
> > > > __synchronize_irq(), as shown in the following trace:
> > > > 
> > > > Call trace:
> > > >      __switch_to+0xe0/0x120
> > > >      __schedule+0x39c/0x978
> > > >      schedule+0x5c/0xf8
> > > >      __synchronize_irq+0x88/0xb4
> > > >      disable_irq+0x3c/0x4c
> > > >      msm_pinmux_set_mux+0x508/0x644
> > > >      pinmux_enable_setting+0x190/0x2dc
> > > >      pinctrl_commit_state+0x13c/0x208
> > > >      pinctrl_pm_select_default_state+0x4c/0xa4
> > > >      geni_se_resources_on+0xe8/0x154
> > > >      qcom_geni_serial_runtime_resume+0x4c/0x88
> > > >      pm_generic_runtime_resume+0x2c/0x44
> > > >      __genpd_runtime_resume+0x30/0x80
> > > >      genpd_runtime_resume+0x114/0x29c
> > > >      __rpm_callback+0x48/0x1d8
> > > >      rpm_callback+0x6c/0x78
> > > >      rpm_resume+0x530/0x750
> > > >      __pm_runtime_resume+0x50/0x94
> > > >      handle_threaded_wake_irq+0x30/0x94
> > > >      irq_thread_fn+0x2c/0xa8
> > > >      irq_thread+0x160/0x248
> > > >      kthread+0x110/0x114
> > > >      ret_from_fork+0x10/0x20
> > > > 
> > > > To fix this, wakeup IRQ setup is moved from probe to UART startup,
> > > > ensuring it is only configured when the port is active. Correspondingly,
> > > > the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
> > > > disable during pinctrl setup and prevents the observed stall. The probe
> > > > and remove pathsare simplified by removing redundant wakeup IRQ handling.
> > > > 
> > > > Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> > > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > > Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
> > > > Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> > > 
> > > Where did you receive this tag for this patch exactly?
> > 
> > Since Jorge was involved in validating the change, I’ve added him under the
> > Tested-by tag.
> > 
> > Please correct me if I’m not supposed to add this tag myself.
> 
> let's test a bit further Praveen - we need to validate/trace the wake
> path on a real scenairo to make sure it is not cpu intensive (although I
> suspect the 2% was due to the storm you described more than to the code
> path itself)
> 
> I can then provide the tested-by on the list.
> 

um bluetooh comms are broken - reverting the runtime_pm patch fixes it.
and the proposed fix (V2) does not address this scenario.

I agree with the common sentiment, I think the patch should be reverted
in linux-next and better test definition shared.

[    1.451715] Bluetooth: Core ver 2.22
[    1.460668] Bluetooth: HCI device and connection manager initialized
[    1.467034] Bluetooth: HCI socket layer initialized
[    1.471922] Bluetooth: L2CAP socket layer initialized
[    1.476988] Bluetooth: SCO socket layer initialized
[    2.504958] Bluetooth: HCI UART driver ver 2.3
[    2.509427] Bluetooth: HCI UART protocol H4 registered
[    2.514600] Bluetooth: HCI UART protocol LL registered
[    2.519978] Bluetooth: HCI UART protocol Broadcom registered
[    2.525662] Bluetooth: HCI UART protocol QCA registered
[    2.530915] Bluetooth: HCI UART protocol Marvell registered
[    2.764571] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.770503] Bluetooth: HIDP socket layer initialized
[    3.901958] Bluetooth: hci0: setting up wcn399x
[    6.202761] Bluetooth: hci0: command 0xfc00 tx timeout
[    6.212294] Bluetooth: hci0: Reading QCA version information failed (-110)
[    6.219261] Bluetooth: hci0: Retry BT power ON:0
[    8.538729] Bluetooth: hci0: command 0xfc00 tx timeout
[    8.543988] Bluetooth: hci0: Reading QCA version information failed (-110)
[    8.550989] Bluetooth: hci0: Retry BT power ON:1
[   10.810736] Bluetooth: hci0: command 0xfc00 tx timeout
[   10.816095] Bluetooth: hci0: Reading QCA version information failed (-110)
[   10.816110] Bluetooth: hci0: Retry BT power ON:2
[   13.082946] Bluetooth: hci0: command 0xfc00 tx timeout
[   13.088490] Bluetooth: hci0: Reading QCA version information failed (-110):
