Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519241BD031;
	Fri, 27 Sep 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444780; cv=none; b=ueDRlEfp4DCbhFaDSHN9nkPSVWzNnS1lO/3aOctECnXgzvXHv5M4MepoicQvb5Nk8L2juUcp98Lp7q6ERRbj0JyZEKayEfy3Ir98MOzMLftVprgwbxJnUz85aYov4FOKyyGR2pYEQq5LYGIyxpKQlDQSSnj7n2AyWLohmJtAUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444780; c=relaxed/simple;
	bh=JhOaZlnwaQOlxV6otlt+lNsAcIZqgjt6OZLssQZRiBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGouYsoWcqOu4dpbuInB8F1fmEgWL3VYkTxO01btU1n0faVl66DraqZrfK787ye8X1oBO9Y6+0XbsS8gAx8VOvWNS87QMUxHZNOSbrumAonSYnrWdTlo4q6Ry8Kz+gU9AONssXl1dqp/+MX3d8ul8uwr8ESbQ5L6NTMndnr4cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5EVcx007323;
	Fri, 27 Sep 2024 13:46:13 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um4xmsa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Sep 2024 13:46:13 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 06:46:12 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 06:46:10 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jirislaby@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] nilfs2: add ratelimiting to nilfs2 message
Date: Fri, 27 Sep 2024 21:46:09 +0800
Message-ID: <20240927134609.2081458-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bad28d6-0a32-49e1-965b-549ec7a752a3@kernel.org>
References: <0bad28d6-0a32-49e1-965b-549ec7a752a3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WC3_5-L6sh1sCLrthkL0fFBnb0bZ9v66
X-Authority-Analysis: v=2.4 cv=e+1USrp/ c=1 sm=1 tr=0 ts=66f6b725 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=SaqRpEZVwUrnCivqqs8A:9
X-Proofpoint-GUID: WC3_5-L6sh1sCLrthkL0fFBnb0bZ9v66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=514
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409270100

On Fri, 27 Sep 2024 12:46:44 +0200, Jiri Slaby wrote:
> On 27. 09. 24, 11:16, Lizhi Xu wrote:
> > On Fri, 27 Sep 2024 06:59:22 +0200, Jiri Slaby wrote:
> >> You should have aimed this at the nilfs developers...
> > I don't get it.
> 
> You are sending nilfs changes to tty maintainers which is not about right.
Got it, Thanks.

BR,
Lizhi
