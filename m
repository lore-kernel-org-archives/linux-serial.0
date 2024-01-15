Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2722C841;
	Mon, 15 Jan 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mYENTk+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B8C433C7;
	Mon, 15 Jan 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705320243;
	bh=zOt5ghp8Sej9+x+PgxHIPtrITY0lWlcoiI0/IG2hHmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYENTk+9RzF6vj3FSnCR+B8jzYocfIob4aoUJW1BS283wonM6XlIAwRYFedQ6iLbh
	 mVmUPb3hXNAT0BabIfb1A3F6Lb6C5FJJUwic6iei7jCCZshA/H9+rVCZy9PnnyGRQ2
	 5qHnK2hL74bNkaI28uEP54YnoCPZKZv3ft9OqgLM=
Date: Mon, 15 Jan 2024 13:04:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: change the privilege required for tty operarions
Message-ID: <2024011523-crunching-race-8058@gregkh>
References: <2024010247-polio-brittle-1b23@gregkh>
 <20240115082420.13372-1-mengjingzi@iie.ac.cn>
 <2024011523-lifter-narrow-fed3@gregkh>
 <2fed8f4.8c4.18d0c8c1269.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fed8f4.8c4.18d0c8c1269.Coremail.mengjingzi@iie.ac.cn>

On Mon, Jan 15, 2024 at 05:55:22PM +0800, 孟敬姿 wrote:
> &gt; Tested how?  

I have no context here at all, sorry.

Please properly quote your emails when responding, remember some of us
get 1000+ emails a day to deal with.

And are you trying to type html formatting somehow?

confused,

greg k-h
