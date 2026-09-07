Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D04357D0A;
	Mon,  7 Sep 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804337; cv=none; b=cD9AnWfaRE5NOiauq9eYrhX1wt4PBlCI1E7C6jt04NPxnmUxrAp+5No3vTtzt4XzqPiSZrJJa6I+RxE9Xqm7Vh1pBTJFYnpAW3oqu0r94P4D7ESvlkquaEZjR9lh5L/f0Et9Cj+ExPyHfehjRhnywAPetJgWWGpBxdZ8tB9obC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804337; c=relaxed/simple;
	bh=irCQ4jBgKVi9PdwNEEM5T06sY24CnC/GOVKxNfPwso8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLSOhQjwXc36PA0oDYA+LgskTUVC6BWDFj+/oE1WdRbnQYrTPiNDfkni+tzdEeb5MZJwWLIrBRsOtu/V4B6lr1BcLCdmQhh8NNTrHb7tg9RjIvsHMe94Z2uCp0vNrfSmsKlnRnJb5dQy9VQetube2kHOB8KEKZcRZmyc/cYr9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WWLGjDwb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WWLGjDwb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5DGA5yGgA6WfP2iOigvVrpj/b8QvWE0uJAMX/rb27bg=; b=WWLGjDwbVkls5zSmMFgX9TOmdZ
	Dzot4tUT+wMtcsWxNstt3dBm0YdnGl79RGTSdqvy9vUr0o3LhvHize+bmp6yR8+TrWfGSo+rg0aoN
	lySE9Wbm8qOkeu927q2KCdkeMFTSPnDrGXKrnMJnu4yXtRn7D5kWD4D3GMtUwzYzk8UE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3diO-003aXf-M0; Mon, 07 Sep 2026 20:05:08 +0200
Date: Mon, 7 Sep 2026 20:05:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] powerpc: fix typos and repeated words in comments
Message-ID: <b1f18b1e-dd7c-4e12-9a87-c7ee5e69697c@lunn.ch>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907065153.33578-1-hemanth.selam@gmail.com>

>  drivers/net/ethernet/ibm/ibmvnic.h                     |  4 ++--

Please split this one out and subnet it to netdev.

    Andrew

---
pw-bot: cr
