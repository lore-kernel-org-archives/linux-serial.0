Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507D495EE
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LevDvwMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD6C433C7;
	Tue, 21 Nov 2023 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700569137;
	bh=+hDiI7oA7w2GVAiKg2/RFvVoNsawMCCEwiX6G5phNJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LevDvwMan1rONnWihkR90a2UXVXOxJMe0dC483raqXQpEMIEu+uKEa6ToFNQNa2bc
	 P2u8bTE1sVIMrVO9RctbSdAsezzzk8gHiMd3rNi1Zj31nWUDAXza+LruXoZW5cfeMc
	 SWQ+QRqZDiQduSTiN2WnsbHQ3HA1Hutbe5uTA/94N/HOObrOExfPsXO0njuuBAyaNy
	 dcer9ztuHU0f3jRGbTMZJGvjEVjzK9SuswXim5Fqi9eWfkt/bro1jeInIk4Vp3do8D
	 Pwnf8NZXrmxjeE3YMyEZP1rKyXNgFxzxlPh6NdSlAOGMlSSdgFFo8rWwMW5p2hBW6k
	 OYmc5DbUoyuZA==
Date: Tue, 21 Nov 2023 13:18:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/6] tty: ipwireless: remove unused
 ipw_dev::attribute_memory
In-Reply-To: <20231121103626.17772-3-jirislaby@kernel.org>
Message-ID: <nycvar.YFH.7.76.2311211318360.29220@cbobk.fhfr.pm>
References: <20231121103626.17772-1-jirislaby@kernel.org> <20231121103626.17772-3-jirislaby@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> clang-struct [1] found ipw_dev::attribute_memory unused.
> 
> As far as I can see it was never used since the driver merge. Drop it.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>

FWIW

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

