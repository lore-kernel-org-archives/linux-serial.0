Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AE14A61A;
	Fri, 27 Sep 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428598; cv=none; b=EmOoJU6kbirzAuomf84CzKTvLqe5pAFIyx6l6Cc04RXlDQ/CkHlrrP18cHGfEJXKw7myw3k4cRdHt1aJSH/neq1R4lJAiY6UFuirwYJIcseObjcDZM+SENEEVgUzKvRGRqS24H9TD+y9aKmFabTKH4XunVt0Hh4lsQKKqj0d51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428598; c=relaxed/simple;
	bh=AhDXJ+rIAapJD7/QYWO+kwhTmMUOlEi8S2ABxUbaiFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXnn8lAAYwv65WH2c69/mBQVybr+fRy+PF+CV2Sr0GJS9KuISX/GB7BWkAIQuq/LxkdgmQDyJ7vP3x7SFI/4HtsC5gCo3hEPPGBZEsCg/IpTrDOjCXiPVO4n0TrxXd9A1zpLL6679eXO7CBOQrHy+d0djTEDYg9h0Rr0+8FsBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R8hCmT023358;
	Fri, 27 Sep 2024 09:16:30 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um4xmh6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Sep 2024 09:16:30 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 02:16:29 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 02:16:27 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jirislaby@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] nilfs2: add ratelimiting to nilfs2 message
Date: Fri, 27 Sep 2024 17:16:26 +0800
Message-ID: <20240927091626.389423-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7312bc09-5cad-4d0e-a7f5-2891d5b0f15b@kernel.org>
References: <7312bc09-5cad-4d0e-a7f5-2891d5b0f15b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZMZxb4Q7CdJ9owd_aWE9_kt8Tr1OgJLT
X-Authority-Analysis: v=2.4 cv=e+1USrp/ c=1 sm=1 tr=0 ts=66f677ee cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=CqbFbpSiA_3hqo4HwpoA:9
X-Proofpoint-GUID: ZMZxb4Q7CdJ9owd_aWE9_kt8Tr1OgJLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=462
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409270064

On Fri, 27 Sep 2024 06:59:22 +0200, Jiri Slaby wrote: 
> You should have aimed this at the nilfs developers...
I don't get it.

BR,
Lizhi
