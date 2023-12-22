Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E72EB06
	for <linux-serial@vger.kernel.org>; Fri, 22 Dec 2023 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QQ3U0f68"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1A016874DD;
	Fri, 22 Dec 2023 23:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1703283663;
	bh=mBDM9dy1uSXQ5mdNUWEYptAydQ7PGaCo4lx3I6Xm1iM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQ3U0f68U+UDF6njdw7wqkp+5CH3nY5aUkJmHTGAv+Bh6hghB4a7IKVfHB6DT1/XD
	 LJsn7oFC/F01I7NlqILJdcrWlrf9JX+G8kTjIboqR9VzbnRG/YeE5m5hn3dbyFcQWu
	 AKWXDI1MEX4LlWc1dH5Dpoq9WWem3gqVF9vjXuxFfepHQMAoYFPIp2hS2CC2vbmzUO
	 68Lbcwqj+DB/pPK/XFtnkVR6HYbiZOYj5bDJ4GIr9XGvjZy6zsyYtVVGLbgfk6F8ch
	 lG8dOqGXpOSO84PwRIbVWJM7dykkMCfTvjWeEm6hg8nwIcRul97F4sRzN0jLRlcVjN
	 fSj0BbwQSUeKg==
Message-ID: <560dfe3e-f991-4f33-b6b8-d31d6a4caacf@denx.de>
Date: Fri, 22 Dec 2023 23:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: Correct clock error message in function
 probe()
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Tom Rix <trix@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20231222220216.2188-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231222220216.2188-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/22/23 23:02, Christoph Niedermaier wrote:
> Correct the clock error message by changing the clock name.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Fixes: tag missing ?
