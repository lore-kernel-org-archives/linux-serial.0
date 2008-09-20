From: chri <chripell@gmail.com>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 16:30:40 +0200
Message-ID: <cabda6420809200730u4b2f47e7i4ba811fce09aff17@mail.gmail.com>
References: <1221895208650-git-send-email-chripell@gmail.com>
	 <20080920012454.e40f03cc.akpm@linux-foundation.org>
	 <20080920065652.11d76780@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:36228 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYITOan (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 10:30:43 -0400
Received: by ey-out-2122.google.com with SMTP id 6so261360eyi.37
        for <linux-serial@vger.kernel.org>; Sat, 20 Sep 2008 07:30:41 -0700 (PDT)
In-Reply-To: <20080920065652.11d76780@infradead.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Sep 20, 2008 at 3:56 PM, Arjan van de Ven <arjan@infradead.org> wrote:
>
> I do have a question though: what does a signed bitfield of 1 mean?
> I mean.. the variables are "int", so signed.... where will the compiler
> store the sign bit???
>
>

In practice they stored just values 0 and 1 well. 2-complement
representation with 1 bit doesn't have much more space (1 == -1). :-)

Anyway after Andrew comment I stopped using them since I'm too scared:
I'm not sure that it's safe without locking the entire struct.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
