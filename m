Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390738;
	b=OpS/VW9p3A989LQ8JdiYaDEKceiEiEsAWeTedjbd+YU5Qg+DExekS+qvroFc1/bQjhOl
	 8o+Cx/X/ilU8KSSVsmDFMUHDJvuIqSVpc68LA2mBNaBjbKy0DhIHCVrmyJ12Bm3i8s5NR
	 bt+tDAULel5+PjRRYbMxxIeH5dkAC7NkD9ZRwyxrsZuJcPa5tmYKKzJnFHQ+W8tpXOMN/
	 SLtP7fKXhpirP9E9kBD/CS4R2JxCvJV/eJV4kv5OXlKzQ2cPX1vuVmce5ssawR13Mbb5I
	 tIiOh27aPw1oE66oIo87amU+UusZFyJ5GCGYKf2rbcOkWHA0mVxAzWBOWvXd5NWernQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390738;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Olwuchnfg8JxtgfprfcqFRAc5bWziipEM1AXqUbQyJg=;
	b=skWqB4OcHCXsEx2LBNYmEvLS6La+qMUtbNnG/GdITcGN5tFOIm0yZWlr7tUv4H7JUN17
	 hPy3ZNs6cHHvf4rxXzHd4PfP+2iHyc8ncC7r9yyzztITZDlHq/CvJmqPmZrspNTK05GCo
	 U4rx2ZldeUYaIc5VCpEgVk/r7LOlvrpLuKP2rUvN3kzlusUsbwh4pm12BGY6r0iH/rjYj
	 xT+PwWOIX7OmMajPgtEOg3oQhKNjGdhwBYro+5RNyIXue5DUcENNe7WgTi0JDgPVFIVGM
	 44D+aXBsWQrrLzykhFgd/KiJalcmMxiISv4nBywTIufhZq8qK6hjvmE7MAMNHaTg+4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=kmDO7vHv;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4A606A321;
	Wed, 11 Nov 2026 09:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A4A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=kmDO7vHv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=kmDO7vHvaASPQ2nLBg8LNU10ECJpHDR0CI47zW5JGuTFF6iHslI/1aGsVawT5Jdy/q+NCoOWrIYCz
	 cNsCITJSXvEJ2CCRZFdMWkzfyYrsX4hL0c4RieFcBo5KuXKvYUVcJVEykXXjJFU4fy0kyWveIpNgtr
	 I56N8nFioM/htFYk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af43aced1d-a49ad;
	Wed, 11 Nov 2026 17:52:15 +0800 (CST)
X-RM-TRANSID:2ee66af43aced1d-a49ad
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af43acdbdb-d7d33;
	Wed, 11 Nov 2026 17:52:14 +0800 (CST)
X-RM-TRANSID:2ee86af43acdbdb-d7d33
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Wed, 11 Nov 2026 17:52:12 +0800
Message-ID: <20261111095213.1720-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

gentle ping.  Is there anything blocking this patch, or does it just
need more time?

Best regards,
Xiangwu Lai


