From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] serial: set suppress_bind_attrs flag only if
 builtin
Date: Wed, 17 Oct 2018 15:32:23 -0700
Message-ID: <20181017153223.6c4e5156895dad7973f7d059@linux-foundation.org>
References: <20181017140311.28679-1-anders.roxell@linaro.org>
        <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
        <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-serial@vger.kernel.org, tj@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 17 Oct 2018 16:21:08 -0600 Jeffrey Hugo <jhugo@codeaurora.org> wrote:

> On 10/17/2018 4:05 PM, Andrew Morton wrote:
> > On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
> > 
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > 
> > This should have Arnd's Signed-off-by: as well.
> 
> I'm just interested to know, why?

So that Arnd certifies that

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

and all the other stuff in Documentation/process/submitting-patches.rst
section 11!

Also, because section 12 says so :)  And that final sentence is, I
believe, appropriate.
