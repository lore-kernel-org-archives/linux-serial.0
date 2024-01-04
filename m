Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86FC2377E
	for <linux-serial@vger.kernel.org>; Thu,  4 Jan 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEN1/Imo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E0C433C7;
	Thu,  4 Jan 2024 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382130;
	bh=5t7HoWJgCA0PUHnWWgq5gi+IsJNLSMShTrPioWBQprA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEN1/ImoxSJHa6C4HLbuyGi+eYmFSGzJ7Tz8T2aZP7jRx2PWmlAfQdzUgRqUtNd/I
	 9Mmi7s3MOf7mAaLwuCqpnwjPZpv0jyD4QvULVHvWPKl92ult+egJX4kLJrKmpqDDFR
	 tI8CbgTGjdl1w4g0AECjEJdxe7IuAMwqdLQgvC4Y=
Date: Thu, 4 Jan 2024 16:28:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman =?utf-8?B?xb1pbGth?= <roman.zilka@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty/vt: UTF-8 parsing update according to RFC 3629,
 modern Unicode
Message-ID: <2024010413-quickly-crinkly-6c5b@gregkh>
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
 <2023121201-ecosphere-polyester-8d37@gregkh>
 <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
 <e5e7fd4f-acac-41a0-8a36-1f4f71eb7c18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5e7fd4f-acac-41a0-8a36-1f4f71eb7c18@gmail.com>

On Tue, Dec 12, 2023 at 09:26:53PM +0100, Roman Žilka wrote:
> vc_translate_unicode() and vc_sanitize_unicode() parse input to the
> UTF-8-enabled console, marking invalid byte sequences and producing Unicode
> codepoints. The current algorithm follows ancient Unicode and may accept
> invalid byte sequences, pass on non-existent codepoints and reject valid
> sequences.
> 
> The patch restores the functions' compliance with modern Unicode (v15.1 [1]
> + many previous versions) as well as RFC 3629 [2].
> 1. Codepoint space is limited to 0x10FFFF.

Wait, why?  And shouldn't this be an individual patch on it's own?  What
is wrong with the checking we currently have.

> 2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in
>    Unicode and will be accepted.

Accepted when?

> Another option was to complete the set of
>    noncharacters (used to be just those two, now there's more) and preserve
>    the rejection step. This is indeed what Unicode suggests (v15.1, chap.
>    23.7) (not requires), but most codepoints are !iswprint(), so selecting
>    just the noncharacters seemed arbitrary and futile (and unnecessary).

What is this change going to break with existing systems that were
thinking these were invalid characters?

> On the side:
> 3. Corrected/improved the doc of the two functions (esp. @rescan).

Again, a separate commit.  When you have to list the changes out, that
is a huge hint it needs to be broken up into smaller pieces.

thanks,

greg k-h
