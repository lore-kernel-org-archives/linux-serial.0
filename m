From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 08 Feb 2017 15:35:27 +0000
Message-ID: <87lgtg7l1c.fsf@on-the-bus.cambridge.arm.com>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
 <20170208133306.GE15459@leverpostej>
 <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org> (Timur
 Tabi's message of "Wed, 8 Feb 2017 08:09:12 -0600")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Neil Leeder <nleeder@codeaurora.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, shankerd@codeaurora.org, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 08 2017 at  2:09:12 pm GMT, Timur Tabi <timur@codeaurora.org> wrote:
> Mark Rutland wrote:
>
>>> No, only Kryo and Falkor V1 based SOCs have this problem.  Falkor V2
>>> will have this fixed.  We intend to revert these fixes after Falkor
>>> V1 SOCs are no longer supported.
>>
>> Supported by whom?
>
> Qualcomm.
>
>> Generally, once something's upstreamed we expect it to remain supported.
>
> The V1 SOCs are technically pre-production, but still in wide use and
> it will be a while before they are all replaced by V2 SOCs.  It's only
> because of the "ugliness" of the erratum and its work-around that we
> want to git rid of it when we can.

Interesting. How will you guarantee that nobody will ever want to run a
mainline kernel on this box after a certain date? Self-destruct timer?
;-)

As someone who runs mainline on HW that exceeded its "sell-by" date by a
few decades, I'm genuinely interested.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
