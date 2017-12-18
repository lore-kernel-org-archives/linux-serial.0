From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 1/2] serial: stm32: add default console
Date: Mon, 18 Dec 2017 09:31:25 +0100
Message-ID: <625c8e7a-f6b0-3997-527d-408cfe9b5730@st.com>
References: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
 <1512146211-29086-2-git-send-email-ludovic.Barre@st.com>
 <20171215192517.GA27395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171215192517.GA27395@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

hi Greg

Yes, the machine could be boot without console. but our
boards has a console by default. it is just to simplified the
configuration.
you can abandoned this patch, if you prefer.

BR
Ludo

On 12/15/2017 08:25 PM, Greg Kroah-Hartman wrote:
> On Fri, Dec 01, 2017 at 05:36:50PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds by default the console support
>> on stm32.
> 
> Why?  'default y' should only mean "machine will not boot without this".
> And I think your machine will boot without the console, right?  :)
> 
> thanks,
> 
> greg k-h
> 
