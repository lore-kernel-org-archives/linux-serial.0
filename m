Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9C271A9D
	for <linux-serial@vger.kernel.org>; Tue,  1 Jul 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368334; cv=none; b=mSLOd8bekEbKHiwn7S0R14S3Gbr36g3ObG93X1bnIsBHkQrHH5uUoy69rpCuSOJwTtRAft7XSTtoPrxXZFQtocS9iJcxcOJ56I1lSPKtSRJSe89v0z3X1In7lbxGTEvZMlLXtHH7Hl2+pEu/LUXkaHfr9bP/OfSJVSpWRoutcX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368334; c=relaxed/simple;
	bh=QEZ21qlcwB44HosYYOE2/QtOlPopnVPyTlzTQNsGFuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvi5rzPaqZ8wtc5I5DAy3nW1QJU/gRIR9WLwv2dkYVaWbKBvstghnbKfAIuCGDJjr/5w+328sFmYw7QqDIuEuKWaFcNvFTcfRKHNkD/DyGvpEtqQiTWalDL9jigtOGghUcRG4RoRieHmHofPoz5TOiqeIItPv7+RSkptWD0JQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcXtpURC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcXtpURC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619oIRJ000324
	for <linux-serial@vger.kernel.org>; Tue, 1 Jul 2025 11:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wn8dIacluJa4oe1kQscHimYh
	2WUFSc+TGJ60KVihadk=; b=FcXtpURCA3rqRaj2db5Nz7QWjZH3PELmVJ1qUYG5
	G2tJp1PIWDe91UC7tCzakD+6FB1WFzT6vF9tONX13TeHQbxfIlRoZkRqeg9lMIq3
	z+/RmOkVBunY+Q+d+Ux+CcGuXj4TzTpOPDlmUVFDay/unbz2SvAUjrlmGl+ot31c
	+9TOFltv71Y1AlBKMepawxccGLO/R+FGF2nSmP7IRqXcISTixBxEbOlP+g3TZfKX
	eEiLHrpd3AW3hAfG0JzHia1V0HCeQdlOk0TDOTbQT8AanPOVBOAJUJXa0YXhbj6C
	g/eR1pNq1CQ2SfZ+/DjRfJy0NoF1Vmx8m0Q/KMHLJdqHfg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm8kk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Jul 2025 11:12:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3d3f64739so746407585a.0
        for <linux-serial@vger.kernel.org>; Tue, 01 Jul 2025 04:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368331; x=1751973131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn8dIacluJa4oe1kQscHimYh2WUFSc+TGJ60KVihadk=;
        b=QBbXGfcqgjkGdYazFQ4IEQWGjwzdyWNLnIcgHH0nuPkrj70RCKNlgLTPamDGvIzi4M
         FBJwjlC9Emc7XpoP/ydbRk+glIC8GDh0Q6f/Q8Dd84OYf12jDoaiT9mHGZMW1DIkfrj+
         yg1PlNHh/frrSYCC4kBYOkWnL+3pZmNbRr0y8TcP+7Z9ruGku5UY8xC1RyDBuMG5Q7TJ
         NqBi6zm5nb8LzWsTEnJvltUZ12P1j1EFl/SVUPA4sWqNMV+kdLFz6cDDW/43WWCQVXWj
         /kuvOiHyyOruurV5Jo0AZ28gDdDirAGK0QY19IR0s4MLY/1/Xx043M5mt1PxNhK+jotp
         i8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKqx0VzYnuqFNp5hcbndgnFGggfYmV8Q5K9anOD92TRa1BkkKB47dojdGhyzJJpGJ532n6x/v/UXu/OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+B0D5oDq1ygqX+0McwyJpIKirIYE1eYNHy8VwIKRkFIlzow2Z
	fANjSvFLsSX0W1KrL5bvGKsKRTBazBzK0dwazZhlPKkDjdW0F7RiVY8+XsUi+vL2JJ/EmYuRL5Y
	zhmRx3FEDQLk7/aPd+kQAPAFOGpBZFiJXNd2s4EGWVxFwKOF9wEEcZkVPUSUZlg0KRtQ=
X-Gm-Gg: ASbGnctTQlGc1WYoLImK9XkLy7mwDdut/2knK9zNHcehqI1RI/EgEV3sLiw6qc1rSgX
	CWBnqMhjtRGNL1FGwCKlte6patJhd1Vng7Cq7NvsZ5l+QEVNdr1wpcJ1u3LyZpKSLB9Yc355eWF
	F2TYdEtdR7O6S65osKiuG/fGcjMiQHOPIk/Pxps9xpD7gRViHdR29rh2Fq2KiqJELTSwluyPY4z
	eusSMG29HRFunT2uMU7tmy4BS0NGrzQ7w+XLtxnbIt0P2OqGl2nJdsCJybst0NZoAPxLlHVz470
	UAy6c2GTQrO7yrxWKZyKO4l4Vn6Snf28ESQrbFf/NQ9K/U2QEkRYB9zN3T15DwwqHjBTH5cu8wb
	ZbMhvZDZ+24+6jH7BP6cdeUN3Y08WfGh9Ybs=
X-Received: by 2002:a05:620a:6504:b0:7d4:57b7:bbf8 with SMTP id af79cd13be357-7d457b7beb5mr1100025885a.49.1751368330747;
        Tue, 01 Jul 2025 04:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF9diEhxnvxYx9K6OFtUy5pjQeD6hdLrsmwhYyKkExk8FnCoGf4cY0maUEtbdzawGa3/IPCA==
X-Received: by 2002:a05:620a:6504:b0:7d4:57b7:bbf8 with SMTP id af79cd13be357-7d457b7beb5mr1100021485a.49.1751368330318;
        Tue, 01 Jul 2025 04:12:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24038bsm1797002e87.25.2025.07.01.04.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:12:09 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:12:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v6 7/8] serial: qcom-geni: Enable PM runtime for serial
 driver
Message-ID: <tt2crsexdnhlotlo3z5uxyta6jrnnvom7aqwsjvopwueazbuih@2l4h6xjpwlar>
References: <20250606172114.6618-1-quic_ptalari@quicinc.com>
 <20250606172114.6618-8-quic_ptalari@quicinc.com>
 <d6cr4elhrbh27lmlcv5xzuel75uvsgi7klxjkevm7vg4jcbawe@5ojgetrxkag5>
 <f87807c9-5249-4d97-ab89-898b7d8d260d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87807c9-5249-4d97-ab89-898b7d8d260d@quicinc.com>
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=6863c28b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=Jl-IZ22V7OrDAWU4FEoA:9 a=CjuIK1q_8ugA:10 a=-_B0kFfA75AA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 17ZLV9lK3UeHGW1wb92RkEAj0GLRqGN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2OCBTYWx0ZWRfX8nM6cof9hcWB
 Vt+wtYevuJrz9tFjp9BaN1NVlLSFpJVCEOp8fW/MDApG2n27DAx/DL88G1iWOLqJkSmRAHJcPDu
 us4Eb8lA0SdebCUm3jCRGeJT076K2cx0ZKcfLrs7q5SCy39IeYY2tyLAxyv9I22fWHorLM/eNx5
 UP1lCT0cIJ5sN4YBjNsSWRbaG/QM0Hs1d1gfpuMpCPy1J9Y4SpWD1Vi2YZBB3FsBZe9t2LhhSSe
 xL5zGnEnvuGP4b0oII/tWspE4BUO//lY/B650GXrH2d3x72MBZGoQ2keqSNLLkcfqYz2yGCcJr+
 UbMxDoHxH8c5Zf81BO1MMxhN+rsce4Vwe/qDk4Wi+ddhUcedgDy9ekBnn5eLJDmlWhn1Djaky8f
 X9W3kuTpx/xHtXsrkFrKUz7lSrE46mHYqvjAyw1TWnWJMWdZLKq827l/O8Ta31KgekdrRMqJ
X-Proofpoint-GUID: 17ZLV9lK3UeHGW1wb92RkEAj0GLRqGN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010068

On Mon, Jun 30, 2025 at 10:40:25AM +0530, Praveen Talari wrote:
> Hi Bjorn,
> 
> Thank you for review.
> 
> On 6/17/2025 9:23 PM, Bjorn Andersson wrote:
> > On Fri, Jun 06, 2025 at 10:51:13PM +0530, Praveen Talari wrote:
> > > Add Power Management (PM) runtime support to Qualcomm GENI
> > > serial driver.
> > > 
> > 
> > Doesn't this have impact on the behavior outside of your
> > project? Or is the transition from qcom_geni_serial_pm() to explicit
> > RPM merely moving code around?
> > 
> > Seems like this deserves to not be hidden in a middle of a patch series.
> > 
> > > Introduce necessary callbacks and updates to ensure seamless
> > > transitions between power states, enhancing overall power
> > > efficiency.
> > > 
> > 
> > This commit message fails to state why we need runtime PM support in the
> > driver.
> 
> Introduce PM runtime support to the Qualcomm GENI serial driver to enable
> better power efficiency and modularity across diverse resource control
> mechanisms, including Linux and firmware-managed systems.
> 
> As part of this enhancement, the existing qcom_geni_serial_pm() logic to
> use standard PM runtime APIs such as pm_runtime_resume_and_get() and
> pm_runtime_put_sync(). Power state transitions are now handled through
> the geni_serial_resources_on() and geni_serial_resources_off() functions.
> 
> Is it fine?
> Please guide me/correct me if needed

Please start by stating out the problem that you are trying to solve.
There is no actual issue description in your patch.

> 
> Thanks,
> Praveen Talari
> > 
> > Also, start your commit message with a problem description, per
> > https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> > 
> > > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> > > ---
> > > v5 -> v6
> > > - added reviewed-by tag in commit
> > > - added __maybe_unused to PM callback functions to avoid
> > >    warnings of defined but not used
> > > ---
> > >   drivers/tty/serial/qcom_geni_serial.c | 33 +++++++++++++++++++++++----
> > >   1 file changed, 29 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > index b6fa7dc9b1fb..3691340ce7e8 100644
> > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > @@ -1686,10 +1686,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
> > >   		old_state = UART_PM_STATE_OFF;
> > >   	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> > > -		geni_serial_resources_on(uport);
> > > +		pm_runtime_resume_and_get(uport->dev);
> > >   	else if (new_state == UART_PM_STATE_OFF &&
> > >   		 old_state == UART_PM_STATE_ON)
> > > -		geni_serial_resources_off(uport);
> > > +		pm_runtime_put_sync(uport->dev);
> > >   }
> > > @@ -1827,9 +1827,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> > >   		return ret;
> > >   	}
> > > +	pm_runtime_enable(port->se.dev);
> > 
> > Any reason not to use devm_pm_runtime_enable() and avoid the
> > two pm_runtime_disable() below?
> > 
> > Regards,
> > Bjorn
> > 
> > > +
> > >   	ret = uart_add_one_port(drv, uport);
> > >   	if (ret)
> > > -		return ret;
> > > +		goto error;
> > >   	if (port->wakeup_irq > 0) {
> > >   		device_init_wakeup(&pdev->dev, true);
> > > @@ -1839,11 +1841,15 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> > >   			device_init_wakeup(&pdev->dev, false);
> > >   			ida_free(&port_ida, uport->line);
> > >   			uart_remove_one_port(drv, uport);
> > > -			return ret;
> > > +			goto error;
> > >   		}
> > >   	}
> > >   	return 0;
> > > +
> > > +error:
> > > +	pm_runtime_disable(port->se.dev);
> > > +	return ret;
> > >   }
> > >   static void qcom_geni_serial_remove(struct platform_device *pdev)
> > > @@ -1855,9 +1861,26 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
> > >   	dev_pm_clear_wake_irq(&pdev->dev);
> > >   	device_init_wakeup(&pdev->dev, false);
> > >   	ida_free(&port_ida, uport->line);
> > > +	pm_runtime_disable(port->se.dev);
> > >   	uart_remove_one_port(drv, &port->uport);
> > >   }
> > > +static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> > > +	struct uart_port *uport = &port->uport;
> > > +
> > > +	return geni_serial_resources_off(uport);
> > > +}
> > > +
> > > +static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
> > > +{
> > > +	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> > > +	struct uart_port *uport = &port->uport;
> > > +
> > > +	return geni_serial_resources_on(uport);
> > > +}
> > > +
> > >   static int qcom_geni_serial_suspend(struct device *dev)
> > >   {
> > >   	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> > > @@ -1901,6 +1924,8 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
> > >   };
> > >   static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> > > +	SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
> > > +			   qcom_geni_serial_runtime_resume, NULL)
> > >   	SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
> > >   };
> > > -- 
> > > 2.17.1
> > > 

-- 
With best wishes
Dmitry
