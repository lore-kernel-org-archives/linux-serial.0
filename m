From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 3/3] tty: st-asc: Update tty alias
Date: Wed, 7 Mar 2018 08:01:11 +0000
Message-ID: <394e92bd-3e6c-6163-4a9f-66182e41238b@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
 <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
 <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Content-Language: en-US
Content-ID: <7BB7B316A774A240B77F1D5227A15AF9@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob

On 03/06/2018 02:29 PM, Rob Herring wrote:
> On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
>> must include only lowercase and '-'.
>>
>> After having updated all STi boards serial aliases from "ttyASN"
>> to "serialN", st-asc driver need to be updated accordingly as tty
>> aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);
> 
> Again, changing the tty name breaks userspace. You can't do that.
> 
> You need to do something like this:
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index c763253514e9..5f9f01fac6dd 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct
> platform_device *pdev)
>          if (!np)
>                  return NULL;
> 
> -       id = of_alias_get_id(np, ASC_SERIAL_NAME);
> +       id = of_alias_get_id(np, "serial");
> +       if (id < 0)
> +               id = of_alias_get_id(np, ASC_SERIAL_NAME);
> 
>          if (id < 0)
>                  id = 0;
> 
I will fix this too

Patrice
