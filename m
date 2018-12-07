From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Fri, 7 Dec 2018 16:39:01 +0100
Message-ID: <20181207153901.GA29185@kroah.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181207113245.GA30719@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 07, 2018 at 12:32:45PM +0100, Thierry Reding wrote:
> Greg,
> 
> any ideas on how we can move forward here? For reasons given elsewhere
> in this thread I understand that there is no way to make the console
> code run in non-atomic context. Have you ever run into a case where the
> console driver couldn't busy-loop? Were there any solutions to this?

I don't know of any such cases, hardware sucks at times, and we just
have to deal with getting it to work by doing stuff like this :(

> I've looked through quite a few drivers and they all end up with a busy
> loop, waiting for the transmission FIFO to become empty. There are also
> a few implementations for hypervisors that call back into some firmware
> in order to send the characters, but I expect those to do the busy
> looping in the firmware.

busy loops are ok here, as you point out.

> Perhaps the most prominent case that I came across and that is quite
> similar to this discussion is netconsole. There's a lot of code in the
> network layer that exists only to allow using a network device for
> outputting a console. I don't think the changes to the mailbox
> framework are anywhere near as complicated.

Neither do I, I have no objection to your changes at all.

thanks,

greg k-h
