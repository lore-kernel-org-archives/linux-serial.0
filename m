Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA46395240;
	Fri, 21 Aug 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299595; cv=none; b=jwiBpvCaKlfwxVx45zs3VdPsZJteUmt5M4ImBnWFyoWaBI7hg5IyEUz1fUO1FQsk7h87wUvjilHDibN+LteIXRou5LzjmhM6uEsmD1jftAkuJF0PtcUevSci8/oqd+QIVcvadofWXo/oB/JZBOdn0pdB9ezOqgfjtHkwBQfJXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299595; c=relaxed/simple;
	bh=0rmn31QUnFJH5V1ktkeKPXErn8mJHDPcaOeuxoHOv8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9W9rGUJ5sLz5Lp7KXZS6cTfHjLhPGF5h0Vlx19c7Z2RNmax02xJmu/6uXrIGYCJrHt28HxAW+aakkLjFMOJ9S/Yk/Yb4dZoU2O3NxNdchImAAJ8DRZF4b9xk2RAQnLHyWROGytsWAo0ZdCyaIICVfPmmrs1K5GQlS/XDNDYdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WhOTpmHL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhOTpmHL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5TjQ61027447;
	Fri, 21 Aug 2026 08:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NbPgSc6wquWI+IJZHFhY/D+nJC/hRUQ33D6SqCCd09s=; b=WhOTpmHLLHY3WPpZ
	rRQu3n0q0DV5NF9VzfoKzJwhxP2lXbFn8akKZuSLXf+ymIwx88a1azfW/SbWPeF9
	18/+oOKn1I73yX26+ND1pdpSS3hIk5vkbzS++IDfXupigodlJOB3Ge2cSsH7j4uQ
	RHrII7u0Wv9D543dejoq4uY+ncvL5S79Sg5E6+MCuJFJdkIa9HmKTCeuK43bY7nR
	QWQqGe7SQERTmLOGTrOGtaIF51BzwyxRezhCVGhn6FyVkNJXtnTD3BQSGQXcE5sg
	rQFrWHAqxTZWwZ2ZHZpgDmWfrX2IMkU5TQUhrJPe4V8boxGuoL36w4moJHe9emPE
	+sFuog==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d06978m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 08:06:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L86SeS010730;
	Fri, 21 Aug 2026 08:06:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g2h6jq93k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 08:06:28 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67L86SA0010724;
	Fri, 21 Aug 2026 08:06:28 GMT
Received: from bt-iot-sh05-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 67L86SQg010723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 08:06:28 +0000 (GMT)
Received: by bt-iot-sh05-lnx.qualcomm.com (Postfix, from userid 4260555)
	id 3DED2410D3; Fri, 21 Aug 2026 16:06:27 +0800 (CST)
From: Xin Chen <xin.chen2@oss.qualcomm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Xin Chen <xin.chen2@oss.qualcomm.com>, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liulzhao@qti.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        cxin@qti.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline data
Date: Fri, 21 Aug 2026 16:06:27 +0800
Message-ID: <20260821080627.3935370-1-xin.chen2@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026081851-krypton-shady-b18d@gregkh>
References: <2026081851-krypton-shady-b18d@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA1OCBTYWx0ZWRfXzfmo7DPJLKnB
 ShZI7KN7605kyA0eJlxzluyg6QX4UQSapodxiwQOa0s7i44A/W//eT7LzWIKC3tEjocoxiTw69V
 NJaiNf1E7knZziXj3AqpAXLYzqg8BiOaX4I9Mv+IDqNGSo8j3sVKie6QgNG1u65gXllvz3txakX
 +7NuJnrcTPydn51UGuuo9TBFdMl3zZAb3sYN6UFcj++K2iUDieeOFZBODErrVhVCp5jWql8SrtG
 N0+hAYPVkMzzLx9Z7icqq7Z0CDxbx2T6B/qDwWoxgwoPJop8JF7NsHzvB4ghrnYKYyeCclITSxm
 bJaZ7MqKSnw7KNqt19+O8j1m8k0FOcqfHjx51VjqQ8quZvINd7iQWEyulAZ/jO4bGJxjmnJ0GSR
 QjPnmMPKS/QZUjApiSfLp4Xz8FEYvn0d1P4DZ8mGPsdtl6tvGsvYDgKigo9G6FLkuvDW4PIsyoo
 /9w6vbIG6EbE1JJrRBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA1OCBTYWx0ZWRfXxd0174XCGhpG
 IFIXUmY6Rxx3+KEXpBLh9AGiMhdsrYc41Dxp84fXxQkI+n9ljz3AAn4ZeuqS8224k+yqgO9FzKd
 63wCv0pLPIkIrVXsg+Cv+N8DLxkzI40=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a880707 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9ZP8Lzs8rE8-CPWomJsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xzL5V7Zw7XkHYIRmmrB0FbARvE2AN_iN
X-Proofpoint-GUID: xzL5V7Zw7XkHYIRmmrB0FbARvE2AN_iN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210058

On Thu, Aug 21, 2026, Greg KH wrote:
> But it's not consuming them "unnecessarily" as the memory is needed.
> Why not fix the root problem here of having this be called so many times
> that you are running out of memory?
>
> And why isn't memory being reclaimed properly if we do not have any left
> in that free list?  The allocation can sleep, so it should be always
> succeeding if the system isn't truely out of memory, as you imply it is
> not.

You raise valid points. I am abandoning this patch.

After further investigation, I followed your suggestion and fixed the
root cause in the Bluetooth layer instead. That fix has since been
applied upstream:

https://lore.kernel.org/all/20260819135321.1444185-1-xin.chen2@oss.qualcomm.com/

Thanks for the review.

Xin
