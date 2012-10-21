if which kde4-config &> /dev/null; then
    export KDE_LOCAL_PREFIX=`kde4-config --localprefix`
fi
