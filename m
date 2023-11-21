Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80D2209F;
	Tue, 21 Nov 2023 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4TUrZed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A45EC433C8;
	Tue, 21 Nov 2023 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605802;
	bh=j7aU0i8BzZ0LWN5tC676qAeLCJLeUSdku5k+b6N9i6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4TUrZedEFvbcBlmmpC9Gs1a7TVbDWGT56xCuhYva+NYZSlcBAYnXPnatx2olRHoy
	 cGv4loLsDlRqCfWUG4NJs52rF1IbrFzMPv5N1ZaQSL+x2v0dd16kkgOSQVSKJ8m/Gu
	 OXqU5f4nxSrOyWjFTI1flvbSjMS8ws5A/ie76W8mLhulU6EJg4vMGuuEgLgstfVu/m
	 mOgc6GD6PxJ12mT1n1nKNf2jl5FJ/YO4XeCR+HOGolPXaG1VprGtKY+N2bui/EB/g1
	 v8KdRswzCcUSyLg6JRj7e+GFfYIHSAvLwaucVUBuJCnhBqu5xCtP2b6dE3G6Wux2Jx
	 HAfvsv8hprMNw==
Date: Tue, 21 Nov 2023 14:30:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 09/17] tty: hso: don't emit load/unload info to the log
Message-ID: <20231121143001.4990312c@kernel.org>
In-Reply-To: <20231121092258.9334-10-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
	<20231121092258.9334-10-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 10:22:50 +0100 Jiri Slaby (SUSE) wrote:
> It's preferred NOT to emit anything during the module load and unload
> (in case the un/load was successful). So drop these prints from hso
> along with global 'version'. It even contains no version after all.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>
