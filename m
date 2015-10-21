From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Which is better to specify console, "console= " or "stdout-path" ?
Date: Wed, 21 Oct 2015 14:09:42 +0900
Message-ID: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi.


I think there exist two ways to specify the console port and baudrate.


[1] Specify console in bootargs

  chosen {
        bootargs = "console=ttyS0,115200";
  };


[2] Specify stdout-path

   chosen {
         stdout-path = "serial0:115200n8";
   };



Now I have both in my DTS, but it is redundant.

So, I want to select either [1] or [2].


Which is a preferable way?


Thanks,



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
