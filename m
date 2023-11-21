Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xu29vfSy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n2waHFKB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D491BF1;
	Tue, 21 Nov 2023 10:37:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16A2E2193C;
	Tue, 21 Nov 2023 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700591853;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17fwntM2BUitSmxQD/3FyPFXOrLp/EyPR6vZWAaaNbQ=;
	b=Xu29vfSyPH6Eni6Cs9SzWD9p605UHUxKACQ+5hDZfVAu+7leM1yvOFLiHaE18lKQ4JM7ZC
	+XrC53eXRtzjQiWQm1bwhffS9jIvYxyVR9yq6cclbU57w8v/GXF8hXOei/XkV9IETQ26iZ
	kco44U0LucS+ijLAX2hqyoOyqsnTRuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700591853;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17fwntM2BUitSmxQD/3FyPFXOrLp/EyPR6vZWAaaNbQ=;
	b=n2waHFKBO1bfFzM+WK+4BnrNsCq2g4jzVkxQB/wIVXrvp7NAyTtpbdb/TWDS2nJ60JNFP/
	5RZxxSM2ELYF4aBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B7D138E3;
	Tue, 21 Nov 2023 18:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1yd/Nuz4XGXfUQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 18:37:32 +0000
Date: Tue, 21 Nov 2023 19:30:23 +0100
From: David Sterba <dsterba@suse.cz>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/6] tty: ipwireless: remove unused
 ipw_dev::attribute_memory
Message-ID: <20231121183023.GV11264@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231121103626.17772-1-jirislaby@kernel.org>
 <20231121103626.17772-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121103626.17772-3-jirislaby@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.73
X-Spamd-Result: default: False [-7.73 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.73)[98.82%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On Tue, Nov 21, 2023 at 11:36:22AM +0100, Jiri Slaby (SUSE) wrote:
> clang-struct [1] found ipw_dev::attribute_memory unused.
> 
> As far as I can see it was never used since the driver merge. Drop it.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>

Acked-by: David Sterba <dsterba@suse.com>
